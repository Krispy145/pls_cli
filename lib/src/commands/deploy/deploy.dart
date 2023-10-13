import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:render_cli/src/commands/base.dart';
import 'package:render_cli/src/commands/deploy/git_config.dart';
import 'package:render_cli/src/utils/find_project_root.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

/// The git config for the deploy
const deployEmail = "skateoasisdubai@gmail.com";

/// The git config for the deploy
const deployName = "skateoasisdubai";

/// {@template deployCommand}
/// Add various parts the app.
/// {@endtemplate}
class DeployCommand extends RenderCommand {
  /// All the available deploy environments
  static const environments = ["staging", "prod"];

  /// {@macro deployCommend}
  DeployCommand() {
    argParser
      ..addOption(
        "environment",
        abbr: "e",
        help: "Select the environment for the build.",
      )
      ..addOption(
        "version",
        abbr: "v",
        help: "Set the build number and version",
      );
  }

  @override
  String get description => "Set version number, tag and push";

  @override
  String get name => "deploy";

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) {
      if (stderr.hasTerminal) {
        logger.err("No argument results found");
      }
      return;
    }
    // Check if the user is in the root folder
    if (!Directory.current.listSync().any((e) => e is File && p.basename(e.path) == "pubspec.yaml")) {
      logger.err("You are not in the root folder");
      return;
    }
    final environment = _getEnv(results);
    if (environment == null) {
      logger.err("Environment is null");
      return;
    }
    final version = await _getVersionNumber(results);
    if (version == null) {
      logger.err("Environment ($environment) or version ($version) is null");
      return;
    }
    final tag = "$environment/$version";

    final releaseMessage = logger.prompt(
      prompt: "${'?'.bold.greenBright} Release message:",
    );

    // final check before changing anything
    logger
      ..info(
        "\n\n${'Check the details below'.green.bold}",
      )
      ..info("${'Tag to push: '.bold} $tag")
      ..info("${'Version:'.bold} $version")
      ..info("${'Release message: '.bold} $releaseMessage");

    final confirm = logger.confirm(prompt: "Confirm environment and version");
    if (!confirm) return;

    final pubspecFile = findPubspec();
    final pubspec = pubspecFile.readAsStringSync();

    final projectName = getProjectName(pubspec);

    await setVersion(
      pubspecFile: pubspecFile,
      version: version,
      pubspec: pubspec,
    );

    if (projectName == null) {
      logger.err("No name found in pubspec.yaml");
      return;
    }

    return _deploy(
      releaseMessage: releaseMessage,
      environment: environment,
      tag: tag,
      version: version,
      projectName: projectName,
    );
  }

  String? _getEnv(ArgResults results) {
    final environment = results['environment'] as String?;
    // Prompt for env
    if (environment != null) {
      if (environments.contains(environment)) return environment;
      // incorrect environment
      logger
        ..write("The input $environment is not a recognized environment.")
        ..write("The environment must be one of the following:")
        ..write(
          DeployCommand.environments.map<String>((r) => "$r\n").join(),
        );
      return null;
    }

    final res = logger.chooseOne(
      prompt: "${'?'.greenBright.bold} Select and environment",
      options: DeployCommand.environments,
    );
    return res;
  }

  Future<String?> _getVersionNumber(ArgResults results) async {
    var version = results["version"] as String?;
    if (version == null || version.isEmpty) {
      final progress = logger.spinner(
        icon: "🏷️",
        rightPrompt: (done) => done ? "Tags fetched" : "Fetching tags",
      );
      await processRunner.run("git", ["fetch", "--tags"], printOutput: false);
      progress.done();
      // list past tags
      logger.info('Previous tags'.greenBright.bold);

      final tagString = await processRunner.runResult(
        "git",
        ["tag", "--list", "-n9"],
        printOutput: false,
      );
      if (tagString != null) {
        final tags = tagString.split("\n").where((element) => element.trim() != "").map((e) {
          final tag = e.trim();
          final splitTag = tag.split(" ");
          var message = "";
          if (splitTag.length > 1) {
            message = splitTag.sublist(1).join(" ");
          }
          final env = splitTag[0].split("+");
          return _Tag(
            buildNumber: int.tryParse(env[1]) ?? 0,
            message: message,
            version: env[0],
          );
        }).toList()
          ..sort((a, b) {
            return a.buildNumber - b.buildNumber;
          });

        final tagStrings = tags.fold<String>(
          "",
          (value, element) => "$value${element.version}+${element.buildNumber} ${element.message}\n",
        );
        logger.info(tagStrings);
      }

      version = logger.prompt(
        prompt: "${'?'.greenBright.bold} Set the new build number: ",
      );
    }
    if (!_verifyVersion(version)) {
      logger.warn('Incorrect version format');
      return null;
    }
    return version;
  }

  bool _verifyVersion(String? version) {
    final exp = RegExp(r"^(\d+)\.(\d+)\.(\d+)\+(\d+)");
    if (version == null || !exp.hasMatch(version)) return false;
    return true;
  }

  /// Get the project name from pubspec
  String? getProjectName(String pubspec) {
    final yaml = loadYaml(pubspec) as YamlMap;
    return yaml["name"] as String;
  }

  /// Sets the version in a pubspec
  Future<void> setVersion({
    required String version,
    required String pubspec,
    required File pubspecFile,
  }) async {
    final yamlEditor = YamlEditor(pubspec)..update(["version"], version);
    await pubspecFile.writeAsString(yamlEditor.toString());
  }

  void _setGitConfig(GitConfig config) {
    processRunner
      ..runResult("git", ["config", "--local", "user.email", config.email])
      ..runResult("git", ["config", "--local", "user.name", config.name]);
  }

  /// Checkout and deploy the branch
  ///
  /// Returns exit code
  Future<void> _deploy({
    required String releaseMessage,
    required String environment,
    required String version,
    required String tag,
    required String projectName,
  }) async {
    var currentBranch = await processRunner.runResult(
      "git",
      ["rev-parse", "--abbrev-ref", "HEAD"],
    );
    if (currentBranch == null) {
      logger.err("Error getting the current branch");
      return;
    }
    currentBranch = currentBranch.trim();

    // Don't allow deploying from a deploy branch as these will get wiped in the process
    if (currentBranch == "staging" || currentBranch == "production") {
      logger.err(
        "Cannot deploy from a deployment only branch",
      );
      return;
    }
    var remoteUrl = await processRunner.runResult(
      "git",
      ["config", "--get", "remote.origin.url"],
    );
    if (remoteUrl == null) {
      logger.err("Error finding remote url");
      return;
    }
    remoteUrl = remoteUrl.trim();

    if (remoteUrl.isEmpty) {
      logger.err("No remote url found");
      return;
    }

    final originDir = Directory.current;
    final tempDir = Directory.systemTemp.createTempSync(
      "$projectName-$environment",
    );

    Directory.current = tempDir;

    // Check out deployment branch when cloning repository, and then remove all
    // the files in the directory. If the 'clone' command fails, assume that
    // the deployment branch doesn't exist, and initialize git in an empty
    // directory, check out a clean deployment branch and add remote.
    final clonedProgress = logger.spinner(
      icon: "✅",
      rightPrompt: (done) => done ? "Project cloned" : "Cloning project",
    );
    var cloneSucceeded = false;

    try {
      final clone = await processRunner.run(
        "git",
        [
          "clone",
          "--depth",
          "1",
          "--branch",
          environment,
          remoteUrl,
          tempDir.path,
        ],
      );
      clonedProgress.done();
      cloneSucceeded = clone.exitCode == 0;
    } catch (_) {
      cloneSucceeded = false;
      clonedProgress.done();
    }
    // final clonedProcess = shell.run(
    //   "git clone",
    //   [
    //     "clone",
    //     "--depth",
    //     "1",
    //     "--branch",
    //     environment,
    //     remoteUrl,
    //     tempDir.path,
    //   ],
    // );

    if (cloneSucceeded) {
      final removeProgress = logger.spinner(
        rightPrompt: (done) => done ? "" : "Removing everything in branch $environment",
      );
      await processRunner.runResult(
        "git",
        ["rm", "-rf", "."],
      );
      removeProgress.done();
    } else {
      await processRunner.runResult("git", ["init"]);
      await processRunner.runResult(
        "git",
        ["checkout", "-b", environment],
      );
      await processRunner.runResult(
        "git",
        ["remote", "add", "origin", remoteUrl],
      );
    }

    await processRunner.runResult(
      "git",
      ["config", "--get", "remote.origin.url"],
    );

    // set config to deploy user
    _setGitConfig(
      GitConfig(email: deployEmail, name: deployName),
    );
    final copyProgress = logger.spinner(
      icon: "🥨",
      rightPrompt: (done) => done ? "Files copied to temp directory." : "Copying files to temp directory branch: $environment",
    );

    try {
      // await copyPathNoGit(originDir.path, tempDir.path);
      await processRunner.runResult(
        "rsync",
        ["-rv", "--exclude=.git", "${originDir.path}/", (tempDir.path)],
      );
    } catch (err) {
      logger.err(
        "Copying build assets from path=$originDir to path=$tempDir failed.",
      );
      rethrow;
    }
    copyProgress.done();

    await processRunner.runResult(
      "git",
      ["add", "--all"],
    );

    final commitResults = await processRunner.run(
      "git",
      ["commit", "-m", "release($version)"],
    );

    var currentCommitId = await processRunner.runResult(
      "git",
      ["rev-parse", "HEAD"],
    );
    if (currentCommitId == null) {
      logger.err("Error getting latest commit id");
      return;
    }
    currentCommitId = currentCommitId.trim();

    // Tag the commit
    await processRunner.runResult(
      "git",
      ["tag", "-a", tag, currentCommitId, "-m", releaseMessage],
    );
    final pushTagProgress = logger.spinner(
      icon: "🔖",
      rightPrompt: (done) => done ? "Tag Pushed" : "Pushing tag",
    );
    await processRunner.runResult(
      "git",
      ["push", "origin", tag],
    );
    pushTagProgress.done();

    final pushProgress = logger.spinner(
      icon: "🌴",
      rightPrompt: (done) => done ? "Pushed branch" : "Pushing branch $environment",
    );
    final pushResult = await processRunner.run(
      "git",
      ["push", "--force", "origin", environment],
    );
    pushProgress.done();

    if (pushResult.exitCode != 0) {
      throw Exception("Running 'git push' command failed.");
    } else if (commitResults.exitCode == 0) {
      // The commit might return a non-zero value when site is up to date.
      logger.info(
        "Project pushed to $environment with tag $tag".greenBright,
      );
    }
  }
}

class _Tag {
  final int buildNumber;
  final String message;
  final String version;

  _Tag({
    required this.buildNumber,
    required this.message,
    required this.version,
  });
}
