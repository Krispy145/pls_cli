import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:mason/mason.dart';
import 'package:render_cli/src/commands/base.dart';
import '../../../bundles/_bundles.dart';

// A valid Dart identifier that can be used for a package, i.e. no
// capital letters.
// https://dart.dev/guides/language/language-tour#important-concepts
final RegExp _identifierRegExp = RegExp('[a-z_][a-z0-9_]*');
final RegExp _orgNameRegExp = RegExp(r'^[a-zA-Z][\w-]*(\.[a-zA-Z][\w-]*)+$');

const _defaultOrgName = 'com.digitalOasis';
const _defaultDescription = 'A Flutter project created by Digital Oasis.';

/// A method which returns a [Future<MasonGenerator>] given a [MasonBundle].
typedef MasonGeneratorFromBundle = Future<MasonGenerator> Function(MasonBundle);

/// A method which returns a [Future<MasonGenerator>] given a [Brick].
typedef MasonGeneratorFromBrick = Future<MasonGenerator> Function(Brick);

/// {@template modelCommand}
/// Add a new model to a flutter project.
/// {@endtemplate}
class CreateFlutterAppCommand extends RenderCommand {
  /// The [MasonBundle] used to generate the project.
  final bundle = flutterTemplateBundle;

  /// {@macro modelCommand}
  CreateFlutterAppCommand() {
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
      );
  }

  @override
  String get description => "Create a new flutter app";

  @override
  String get name => "flutter_app";

  /// Gets the output [Directory].
  Directory get outputDirectory {
    final directory = argResults!['output-directory'] as String? ?? '.';
    return Directory(directory);
  }

  /// Gets the organization name.
  String get orgName {
    final orgName = argResults!['org-name'] as String? ?? _defaultOrgName;
    _validateOrgName(orgName);
    return orgName;
  }

  /// Gets the description for the project.
  String get projectDescription => argResults!['description'] as String? ?? '';

  String? _projectName;
  bool _hasFirebase = false;

  @override
  Future<void> run() async {
    if (argResults == null) {
      logger.err("Invalid argument results");
      return;
    }
    _projectName = _validateProjectName();
    _hasFirebase = argResults!["firebase"] as bool? ?? false;

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

    final generateProgress = logger.progress('Creating');

    try {
      final generator = await MasonGenerator.fromBundle(bundle);

      final vars = getTemplateVars(<String, dynamic>{
        "application_id": iosBundleId,
        "application_id_android": androidBundleId,
      });

      final target = DirectoryGeneratorTarget(outputDirectory);
      final files = await generator.generate(
        target,
        vars: vars,
        fileConflictResolution: FileConflictResolution.overwrite,
        logger: Logger(),
      );

      generateProgress.finish(
        message: 'Generated ${files.length} file(s)',
        showTiming: true,
      );

      // Run scripts defined in pubspec.yaml after project generation
      await _runScripts(_hasFirebase);
    } catch (e) {
      generateProgress.finish(
        message: 'Failed to generate files',
        showTiming: true,
      );
    }
    if (_hasFirebase) {
      logger
        ..info(
          "To finish firebase setup, you must have the flutterfire and the firebase cli installed.",
        )
        ..info("You must also be logged into the firebase cli.")
        ..info("Then run the following command:")
        ..info("→ bash ./tools/firebase_install.sh".green);
    }
  }

  Future<void> _runScripts(bool _hasFirebase) async {
    final projectDirectory = Directory("./$_projectName");
    if (!projectDirectory.existsSync()) {
      logger.err('Project directory not found: $_projectName');
      return;
    }

    // Change the current working directory to the project directory
    Directory.current = projectDirectory;
    logger.info("Changed directory to $_projectName".green);

    await runScripts([
      if (_hasFirebase) 'flutter pub add firebase_core firebase_analytics firebase_crashlytics firebase dynamic_links',
      'flutter clean',
      'flutter pub get',
      'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);

    // Open VS Code with the project directory
    await Process.start('code', ['.']);
  }

  bool _isValidPackageName(String name) {
    final match = _identifierRegExp.matchAsPrefix(name);
    return match != null && match.end == name.length;
  }

  String _validateProjectName() {
    final args = argResults!.rest;

    logger.info('Validating project name; args: $args');

    if (args.isEmpty) {
      usageException('No option specified for the project name.');
    }

    if (args.length > 1) {
      usageException('Multiple project names specified.');
    }

    final name = args.first;
    final isValidProjectName = _isValidPackageName(name);
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

  void _validateOrgName(String name) {
    logger.info('Validating org name; $name');
    final isValidOrgName = _isValidOrgName(name);
    if (!isValidOrgName) {
      usageException(
        '"$name" is not a valid org name.\n\n'
        'A valid org name has at least 2 parts separated by "."\n'
        'Each part must start with a letter and only include '
        'alphanumeric characters (A-Z, a-z, 0-9), underscores (_), '
        'and hyphens (-)\n',
      );
    }
  }

  bool _isValidOrgName(String name) {
    return _orgNameRegExp.hasMatch(name);
  }
}
