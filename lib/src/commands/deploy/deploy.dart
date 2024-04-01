import 'dart:io';
import 'package:ansi_styles/extension.dart';
import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:oasis_cli/src/commands/base.dart';

/// {@template deployCommand}
/// Add various parts the app.
/// {@endtemplate}
class DeployCommand extends UnpackCommand {
  /// All the available deploy environments
  static const environments = ["dev", "stage", "prod"];

  /// All the available version types
  static const versionTypes = ["build", "patch", "minor", "major"];

  /// All the available channels
  static const channels = ["alpha", "beta", "production"];

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
        help: "Set the version type for the build.",
      )
      ..addOption(
        "channel",
        abbr: "c",
        help: "Set the channel for the build.",
      );
  }

  @override
  String get description => "Set the version and deploy the project";

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
    final env = _getEnv(results);
    if (env == null) {
      logger.err("Environment is null");
      return;
    }
    String? version;
    if (env == "dev") {
      version = _getVersionNumber(results);
      if (version == null) {
        logger.err("Environment ($env) or version ($version) is null");
        return;
      }
    }
    String? channel;
    if (env == "dev" || env == "stage") {
      channel = _getChannel(results);
      if (channel == null) {
        logger.err("Channel is null");
        return;
      }
    } else if (env == "prod") {
      channel = "production";
    }

    // final check before changing anything
    logger
      ..info(
        "\n\n${'Check the details below'.green.bold}",
      )
      ..info("${'Environment:'.bold} $env");
    if (channel != null) {
      logger.info("${'Channel:'.bold} $channel");
    }
    if (version != null) {
      logger.info("${'Version:'.bold} $version");
    }

    final confirm = logger.confirm(prompt: "Confirm Deployment Details?");
    if (!confirm) return;

    if (env == "dev" && channel == "alpha") {
      await processRunner.runString(
        "make  bump-version ENV=$env VERSION_TYPE=$version",
      );
    }
    await processRunner.runString(
      "make deploy ENV=$env CHANNEL=$channel",
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

  String? _getVersionNumber(ArgResults results) {
    final version = results["version"] as String?;
    if (version == null || version.isEmpty) {
      final res = logger.chooseOne(
        prompt: "${'?'.greenBright.bold} Select a version type",
        options: DeployCommand.versionTypes,
      );
      return res;
    }
    if (versionTypes.contains(version)) return version;
    logger
      ..write("The input $version is not a recognized version type.")
      ..write("The version must be one of the following:")
      ..write(
        DeployCommand.versionTypes.map<String>((r) => "$r\n").join(),
      );
    return null;
  }

  String? _getChannel(ArgResults results) {
    final channel = results["channel"] as String?;
    if (channel == null || channel.isEmpty) {
      final res = logger.chooseOne(
        prompt: "${'?'.greenBright.bold} Select a channel",
        options: DeployCommand.channels,
      );
      return res;
    }
    if (channels.contains(channel)) return channel;
    logger
      ..write("The input $channel is not a recognized channel.")
      ..write("The channel must be one of the following:")
      ..write(
        DeployCommand.channels.map<String>((r) => "$r\n").join(),
      );
    return null;
  }
}
