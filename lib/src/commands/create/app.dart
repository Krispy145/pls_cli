// ignore_for_file: public_member_api_docs, constant_identifier_names
import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:mason/mason.dart';
import 'package:pls_cli/bundles/_bundles.dart';
import 'package:pls_cli/src/commands/base.dart';
import 'package:pls_cli/src/utils/helpers.dart';
import 'package:pls_cli/src/utils/structures.dart';

const _defaultOrgName = 'com.lets.pls';
const _defaultDescription = 'A Flutter project created by Pls.';

/// A method which returns a [Future<MasonGenerator>] given a [MasonBundle].
typedef MasonGeneratorFromBundle = Future<MasonGenerator> Function(MasonBundle);

/// A method which returns a [Future<MasonGenerator>] given a [Brick].
typedef MasonGeneratorFromBrick = Future<MasonGenerator> Function(Brick);

/// {@template modelCommand}
/// Add a new model the app.
/// {@endtemplate}
class CreateAppCommand extends PLSCommand {
  /// The [MasonBundle] used to generate the project.
  final bundle = appTemplateBundle;
  final String? appName;
  final bool openVSCode;
  final bool isEcoSystem;

  /// {@macro modelCommand}
  CreateAppCommand({this.appName, this.openVSCode = true, this.isEcoSystem = false}) {
    argParser
      ..addFlag(
        "firebase",
        help: "Add firebase to the project",
      )
      ..addOption(
        'output-directory',
        abbr: 'o',
        help: 'The desired output directory when creating a new project.',
      )
      ..addOption(
        'description',
        help: 'The description for this new project.',
        aliases: ['desc'],
        defaultsTo: _defaultDescription,
      )
      ..addOption(
        'org-name',
        help: 'The organization for this new project.',
        defaultsTo: _defaultOrgName,
        aliases: ['org'],
      )
      ..addFlag("open", help: "Open the project in VS Code after creation", defaultsTo: true);
  }

  @override
  String get description => "Create a new flutter app";

  @override
  String get name => "app";

  /// Gets the output [Directory].
  Directory get outputDirectory {
    final directory = argResults?['output-directory'] as String? ?? '.';
    return Directory('$directory/$_projectName');
  }

  /// Gets the organization name.
  String get orgName => argResults?['org-name'] as String? ?? _defaultOrgName;

  /// Gets the description for the project.
  String get projectDescription => argResults?['description'] as String? ?? '';

  String? _projectName;
  bool _hasFirebase = false;

  @override
  Future<void> run() async {
    if (argResults == null && appName == null) {
      logger.err("Invalid argument results");
      return;
    }
    _projectName = _validateProjectName(appName);
    _hasFirebase = argResults?["firebase"] as bool? ?? false;

    final iosBundleId = logger.prompt(
      prompt: "🍎 Please enter your ios bundle id:",
    );

    final androidBundleId = logger.prompt(
      prompt: "🤖 Please enter your android bundle id",
      initialText: iosBundleId,
    );

    final confirm = logger.confirm(
      prompt: "Create project with the following bundle id's \n 🍎 ios: $iosBundleId \n 🤖 android: $androidBundleId \n",
    );

    if (!confirm) return;

    if (!_hasFirebase) {
      _hasFirebase = logger.confirm(
        prompt: "🔥 Would you like to add firebase to this project?",
      );
    }

    final selectedStructure = await _handleProjectStructureSelection();
    final isDefault = selectedStructure == Structure.Default;
    final isDefaultmap = selectedStructure == Structure.DefaultMap;
    final isMap = selectedStructure == Structure.Map;
    final isDashboard = selectedStructure == Structure.Dashboard;
    final isDefaultDashboard = selectedStructure == Structure.DefaultDashboard;

    final generateProgress = logger.progress('Creating $_projectName with flavors');

    try {
      // First, run flutter create
      final createResult = await Process.run('flutter', [
        'create',
        '--org',
        orgName,
        '--project-name',
        _projectName!,
        outputDirectory.path,
      ]);

      if (createResult.exitCode != 0) {
        throw Exception('Failed to create Flutter project: ${createResult.stderr}');
      }

      // Get the absolute path to the project directory
      final projectDir = Directory(outputDirectory.absolute.path);

      // Wait for the directory to be created
      var attempts = 0;
      while (!projectDir.existsSync() && attempts < 10) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        attempts++;
      }

      if (!projectDir.existsSync()) {
        throw Exception('Project directory not created after waiting: ${projectDir.path}');
      }

      // Add flutter_flavorizr as a dev dependency
      final addResult = await Process.run(
        'flutter',
        ['pub', 'add', 'flutter_flavorizr', '--dev'],
        workingDirectory: projectDir.path,
      );
      if (addResult.exitCode != 0) {
        throw Exception('Failed to add flutter_flavorizr: ${addResult.stderr}');
      }

      // Create flavorizr.yaml
      final flavorizrYaml = File('${projectDir.path}/flavorizr.yaml');

      // Get the template content from the package's assets
      final templateContent = '''
flavors:
  development:
    app:
      name: "$_projectName Dev"
    android:
      applicationId: "$androidBundleId.dev"
    ios:
      bundleId: "$iosBundleId.dev"
    macos:
      bundleId: "$iosBundleId.dev"
      buildSettings:
        LD_RUNPATH_SEARCH_PATHS:
          - "\$(inherited)"
          - "@executable_path/../Frameworks"
  staging:
    app:
      name: "$_projectName Staging"
    android:
      applicationId: "$androidBundleId.staging"
    ios:
      bundleId: "$iosBundleId.staging"
    macos:
      bundleId: "$iosBundleId.staging"
      buildSettings:
        LD_RUNPATH_SEARCH_PATHS:
          - "\$(inherited)"
          - "@executable_path/../Frameworks"
  production:
    app:
      name: "$_projectName"
    android:
      applicationId: "$androidBundleId"
    ios:
      bundleId: "$iosBundleId"
    macos:
      bundleId: "$iosBundleId"
      buildSettings:
        LD_RUNPATH_SEARCH_PATHS:
          - "\$(inherited)"
          - "@executable_path/../Frameworks"
''';

      await flavorizrYaml.writeAsString(templateContent);

      // Run flutter_flavorizr
      final flavorizrProcess = await Process.start(
        'flutter',
        ['pub', 'run', 'flutter_flavorizr', '-f'],
        workingDirectory: projectDir.path,
        mode: ProcessStartMode.inheritStdio,
      );

      final exitCode = await flavorizrProcess.exitCode;
      if (exitCode != 0) {
        throw Exception('Failed to run flutter_flavorizr: Exit code $exitCode');
      }

      // Now generate the additional structure from your Mason brick
      final generator = await MasonGenerator.fromBundle(bundle);

      final vars = getTemplateVars(<String, dynamic>{
        "application_id": iosBundleId,
        "application_id_android": androidBundleId,
        "is_default": isDefault || isDefaultmap || isDefaultDashboard,
        "is_default_map": false,
        "is_map": isMap || isDefaultmap,
        "is_dashboard": isDashboard || isDefaultDashboard,
      });

      // Create a temporary directory for the Mason template
      final tempDir = Directory.systemTemp.createTempSync();
      final target = DirectoryGeneratorTarget(tempDir);

      // Generate the template to temp directory first
      await generator.generate(
        target,
        vars: vars,
        fileConflictResolution: FileConflictResolution.overwrite,
        logger: Logger(),
      );

      // Print the contents of the Mason tempDir for debugging
      print('TempDir contents:');
      tempDir.listSync(recursive: true).forEach((e) => print('  ${e.path}'));

      // Copy the lib directory from the Mason output
      await _copyDirectory(
        '${tempDir.path}/lib',
        '${projectDir.path}/lib',
      );

      // Copy additional common folders/files from the Mason output
      final commonFolders = [
        '.vscode',
        '.github',
        if (_hasFirebase) 'tools',
        'assets',
        'test',
        'Makefile',
        'build.yaml',
        'analysis_options.yaml',
        '.gitignore',
        'README.md',
        'pubspec.yaml',
      ];

      for (final item in commonFolders) {
        final sourcePath = '${tempDir.path}/$item';
        final destPath = '${projectDir.path}/$item';
        if (Directory(sourcePath).existsSync()) {
          await _copyDirectory(sourcePath, destPath);
        } else if (File(sourcePath).existsSync()) {
          await File(sourcePath).copy(destPath);
        } else {
          logger.warn('Did not find $item in Mason output: sourcePath: $sourcePath - destPath: $destPath');
        }
      }

      generateProgress.finish(
        message: 'Generated project with flavors and custom structure',
        showTiming: true,
      );

      // Run the scripts
      await _runScriptsWithFlavors(_hasFirebase, selectedStructure, projectDir.path);
    } catch (e) {
      generateProgress.finish(
        message: 'Failed to generate files: $e',
        showTiming: true,
      );
      rethrow;
    }
  }

  Future<void> _copyDirectory(String source, String destination) async {
    final sourceDir = Directory(source);
    if (!sourceDir.existsSync()) return;

    final destDir = Directory(destination);
    if (!destDir.existsSync()) {
      await destDir.create(recursive: true);
    }

    await for (final entity in sourceDir.list(recursive: true)) {
      final relativePath = entity.path.substring(source.length + 1);
      final destPath = '$destination/$relativePath';

      if (entity is File) {
        await entity.copy(destPath);
      } else if (entity is Directory) {
        await Directory(destPath).create(recursive: true);
      }
    }
  }

  Future<void> _runScriptsWithFlavors(bool hasFirebase, Structure selectedStructure, String projectDirectory) async {
    logger.info('Running scripts'.blue);
    final shouldOpen = argResults?["open"] as bool? ?? openVSCode;

    if (!Directory(projectDirectory).existsSync()) {
      logger.err('Project directory not found: $projectDirectory');
      return;
    }

    if (isEcoSystem) {
      await replaceAllInDirectory(
        Directory(projectDirectory),
        {'../packages': '../../packages'},
      );
    }

    final libDirectory = Directory('$projectDirectory/lib');
    if (!libDirectory.existsSync()) {
      logger.err('lib directory not found in the project.');
      return;
    }

    // Run each command individually with the working directory
    final commands = [
      if (hasFirebase) 'flutter pub add firebase_core firebase_analytics firebase_crashlytics firebase_dynamic_links',
      "pls add structure --type ${selectedStructure.name}",
      if (!isEcoSystem) ...[
        "pls add feature --name home --project=$_projectName",
        'flutter clean',
        'flutter pub upgrade --major-versions',
        'dart format .',
        'dart run flutter_native_splash:create',
        'flutter pub run build_runner build --delete-conflicting-outputs',
      ],
    ];

    for (final command in commands) {
      final result = await Process.run(
        'sh',
        ['-c', command],
        workingDirectory: libDirectory.path,
      );
      if (result.exitCode != 0) {
        logger.err('Failed to run command: $command\nError: ${result.stderr}');
      }
    }

    if (_projectName != null) {
      final replaceStringsMap = {
        'parentNameTemplate': _projectName!.camelCase,
        'ParentNameTemplate': _projectName!.pascalCase,
        'parent_name_template': _projectName!.snakeCase,
        'appTemplate': _projectName!.camelCase,
        'app_template': _projectName!.snakeCase,
        'App Template': _projectName!.titleCase,
        'AppTemplate': _projectName!.pascalCase,
      };
      await replaceAllInDirectory(
        Directory(projectDirectory),
        replaceStringsMap,
      );
    }

    if (shouldOpen) await Process.start('code', [projectDirectory, '$projectDirectory/README.md', '--wait']);
  }

  Future<Structure> _handleProjectStructureSelection() async {
    final selectedStructure = logger.chooseOne(
      prompt: 'Select the app structure:',
      options: Structure.values.map((e) => e.name).toList(),
    );

    return Structure.values.firstWhere((element) => element.name == selectedStructure);
  }

  String _validateProjectName(String? appName) {
    final args = argResults?.rest ?? [];

    logger.info('Validating project name; args: $args');

    if (args.isEmpty && appName == null) {
      usageException('No option specified for the project name.');
    }

    if (args.length > 1 && appName == null) {
      usageException('Multiple project names specified.');
    }

    final name = appName ?? args.first;
    final isValidProjectName = isValidDirectoryName(name);
    if (!isValidProjectName) {
      usageException(
        '"$name" is not a valid package name.\n\n'
        'See https://dart.dev/tools/pub/pubspec#name for more information.',
      );
    }
    return name;
  }

  /// Responsible for returns the template parameters to be passed to the
  /// template brick.
  ///
  /// Override if the create sub command requires additional template
  /// parameters.
  ///
  /// For subcommands that mix with OrgName, it includes 'org_name'.
  /// For subcommands that mix with Publishable, it includes 'publishable'.
  Map<String, dynamic> getTemplateVars(Map<String, dynamic>? vars) {
    final projectDescription = this.projectDescription;

    return <String, dynamic>{
      'project_name': _projectName,
      'description': projectDescription,
      'org_name': orgName,
      "has_firebase": _hasFirebase,
      ...vars ?? <String, dynamic>{},
    };
  }
}
