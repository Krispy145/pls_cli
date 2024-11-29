// import 'package:args/command_runner.dart';
import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:lets_yak_cli/src/commands/brick_command_base.dart';
import 'package:lets_yak_cli/src/utils/data_sources.dart';
import 'package:lets_yak_cli/src/utils/helpers.dart';
import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';

/// {@template packageCommand}
/// Create a new Lets Yak package.
/// {@endtemplate}
class PackageCommand extends BrickCommandBase {
  /// {@macro packageCommand}
  PackageCommand() {
    argParser
      ..addFlag("wrapper", help: _wrapperPrompt)
      ..addFlag("data", help: _dataPrompt)
      ..addFlag("domain", help: _domainPrompt)
      ..addFlag("presentation", help: _presentationPrompt)
      ..addFlag("open", help: "Open the project in VS Code after creation", defaultsTo: true)
      ..addFlag("ecosystem", help: "Create a package in a monorepo")
      ..addOption(
        'feature',
        help: 'The name of the feature',
        valueHelp: 'feature_name',
      );
  }

  final _wrapperPrompt = "Do you want a wrapper for this package?";
  final _dataPrompt = "Do you want a data layer for this package?";
  final _domainPrompt = "Do you want a domain layer for this package?";
  final _presentationPrompt = "Do you want a presentation layer for this package?";

  @override
  final MasonBundle bundle = packageBundle;

  @override
  String get description => "Creates a new Lets Yak package";

  @override
  String get name => "package";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final shouldOpen = argResults?["open"] as bool? ?? additionalArgs?["open"] as bool? ?? true;
    final isEcoSystem = argResults?["ecosystem"] as bool? ?? additionalArgs?["ecosystem"] as bool? ?? true;
    var featureName = argResults?["feature"] as String? ?? additionalArgs?["feature"] as String?;

    // Save the current working directory
    final currentDirectory = Directory.current;

    // Get the package name
    var packageName = argResults?["name"] as String? ?? additionalArgs?["name"] as String?;
    while (packageName == null) {
      logger.info("In while loop");
      final name = logger.prompt(
        prompt: "What's the name of your package",
        validator: isValidDirectoryName,
      );
      if (name.isNotEmpty) {
        if (isValidDirectoryName(name)) {
          packageName = name;
          break;
        } else {
          logger.info("Invalid name. Must be snake_case 💪");
        }
      }
    }

    argParser.parse(['--name=$packageName']);

    var data = argResults?["data"] as bool? ?? false;
    if (data != true && !isEcoSystem) {
      data = logger.confirm(prompt: _dataPrompt);
      if (data) argParser.parse(["--data"]);
    }

    var domain = argResults?["domain"] as bool? ?? false;
    if (domain != true && !isEcoSystem) {
      domain = logger.confirm(prompt: _domainPrompt);
      if (domain) argParser.parse(["--domain"]);
    }

    var presentation = argResults?["presentation"] as bool? ?? false;
    if (presentation != true && !isEcoSystem) {
      presentation = logger.confirm(prompt: _presentationPrompt);
      if (presentation) argParser.parse(["--presentation"]);
    }

    if (presentation || domain || data || isEcoSystem) {
      featureName ??= logger.prompt(
        prompt: "What is the name of the feature?",
        validator: isValidDirectoryName,
      );
    }
    var dataSourceList = <String>[];
    if (data || isEcoSystem) {
      dataSourceList = logger.chooseMany(
        prompt: "Choose the data sources you want to add",
        options: DataSourceTypes.values.map((e) => e.name).toList(),
        initialIndices: DataSourceTypes.values.map((e) => e.defaultPrompt).toList(),
      );
    }

    final dataSourcesFlags = dataSourceList.map((e) => "--$e").toList().join(" ");

    final packagePath = "${Directory.current.path}/$packageName";

    await runScripts(
      [
        'flutter create --template=package $packageName',
      ],
    );
    await super.run(
      additionalArgs: {
        "name": packageName,
        "path": packagePath,
      },
    );
    final packageDirectory = Directory(packagePath);
    if (!packageDirectory.existsSync()) {
      logger.err('Project directory not found: $packageName');
      return;
    }

    // Change the current working directory to the project directory
    Directory.current = packageDirectory;
    logger.info("Changed directory to $packageName".blue);

    // Now, change into the lib directory
    final libDirectory = Directory('./lib');
    if (!libDirectory.existsSync()) {
      logger.err('lib directory not found in the project.');
      return;
    }

    final dataLayerScript = isEcoSystem
        ? 'yak add data_layer --name=$featureName --project=$packageName $dataSourcesFlags'
        : data
            ? 'yak add data_layer --name=$packageName --project=$packageName'
            : null;
    final domainLayerScript = isEcoSystem
        ? 'yak add domain_layer --name=$featureName --project=$packageName'
        : domain
            ? 'yak add domain_layer --name=$packageName --project=$packageName'
            : null;
    final presentationLayerScript = presentation ? 'yak add presentation_layer --name=$packageName --project=$packageName' : null;

    Directory.current = libDirectory;
    logger.info("Changed directory to lib".blue);
    await runScripts(
      [
        if (dataLayerScript != null) dataLayerScript,
        if (domainLayerScript != null) domainLayerScript,
        if (presentationLayerScript != null) presentationLayerScript,
        if (!isEcoSystem) ...[
          'flutter clean',
          'flutter pub get',
          'flutter pub run build_runner build --delete-conflicting-outputs',
          'dart format .',
        ],
      ],
    );

    // Change the current working directory back to the original project directory
    Directory.current = packageDirectory;
    logger.info("Changed directory back to $packageName".blue);
    final replaceStringsMap = {
      'parentNameTemplate': packageName.camelCase,
      'ParentNameTemplate': packageName.pascalCase,
      'parent_name_template': packageName.snakeCase,
    };
    if (isEcoSystem) replaceStringsMap['../../packages'] = '../../../packages';

    await replaceAllInDirectory(
      Directory.current,
      replaceStringsMap,
    );

    Directory.current = currentDirectory;
    logger.info("Changed directory back to ${currentDirectory.path}".blue);
    await replaceAllInDirectory(
      Directory.current,
      {
        '# MELOS_PACKAGE_LIST_END': '- ${packageName.snakeCase}\n # MELOS_PACKAGE_LIST_END',
      },
    );

    // Open VS Code with the project directory
    if (shouldOpen) await Process.start('code', ['.', './$packageName/README.md']);
  }
}
