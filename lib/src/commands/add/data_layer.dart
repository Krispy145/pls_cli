import 'dart:io';

import 'package:lets_yak_cli/src/utils/helpers.dart';
import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template dataCommand}
/// Add a data layer for the app.
/// {@endtemplate}
class DataLayerCommand extends BrickCommandBase {
  /// [DataLayerCommand] constructor
  DataLayerCommand() {
    argParser
      ..addOption(
        'project',
        help: 'The name of the project',
        valueHelp: 'project_name',
      )
      ..addFlag(
        'api',
        help: 'Whether to add an API Data Source',
      )
      ..addFlag(
        'assets',
        help: 'Whether to add an Assets Data Source',
      )
      ..addFlag(
        'dummy',
        help: 'Whether to add a Dummy Data Source',
        defaultsTo: true,
      )
      ..addFlag(
        'firestore',
        help: 'Whether to add a Firestore Data Source',
      )
      ..addFlag(
        'hive',
        help: 'Whether to add a Hive Data Source',
      )
      ..addFlag(
        'secure',
        help: 'Whether to add a Secure Data Source',
      )
      ..addFlag(
        'supabase',
        help: 'Whether to add a Supabase Data Source',
      );
  }
  @override
  final MasonBundle bundle = dataLayerBundle;

  @override
  String get description => "Creates a new data layer for the app";

  @override
  String get name => "data_layer";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final buildRunner = argResults?['runner'] as bool? ?? additionalArgs?['runner'] as bool? ?? false;
    final projectName = argResults?['project'] as String? ?? additionalArgs?['project'] as String?;
    final _featureName = argResults?['name'] as String? ??
        additionalArgs?['name'] as String? ??
        logger.prompt(
          prompt: "What is the name of the data_layer?",
          validator: isValidDirectoryName,
        );
    await super.run();
    _addRepositoriesFile(_featureName);
    if (projectName != null) {
      final replaceStringsMap = {
        'parentNameTemplate': projectName.camelCase,
        'ParentNameTemplate': projectName.pascalCase,
        'parent_name_template': projectName.snakeCase,
      };
      await replaceAllInDirectory(
        Directory.current,
        replaceStringsMap,
      );
    }
    return runScripts([
      'yak add logger --name=$_featureName',
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }

  void _addRepositoriesFile(String name) {
    final currentDirectory = argResults?["path"] != null ? Directory(argResults!["path"] as String) : Directory.current;

    if (!currentDirectory.existsSync()) {
      logger.err('Current directory does not exist.');
      return;
    }

    // Define the path to the repositories directory
    final repositoriesDirectory = Directory('${currentDirectory.path}/data/repositories');
    if (!repositoriesDirectory.existsSync()) {
      logger.info('Creating repositories directory');
      repositoriesDirectory.createSync();
    }

    // Define the path to the _repositories.dart file
    final file = File.fromUri(
      repositoriesDirectory.uri.resolve('_repositories.dart'),
    );

    // Check if the file already exists
    final fileExists = file.existsSync();
    final _repositoryString = '''
/// [${name.camelCase}] is the [${name.pascalCase}DataRepository] instance.
  final ${name.pascalCase}DataRepository ${name.camelCase} = ${name.pascalCase}DataRepository();

  ///END OF REPOSITORIES
  ''';

    if (fileExists) {
      logger.info('$name repository already exists');
      // Read the existing file content
      final fileContent = file.readAsStringSync();

      // Check if the content already contains the repository string
      if (!fileContent.contains(_repositoryString)) {
        logger.info('Adding $name repository to repositories file');

        // Modify the content and write it back
        final modifiedContent = fileContent
            .replaceFirst(
              '///END OF IMPORTS',
              "import '${name.snakeCase}.repository.dart';\n///END OF IMPORTS",
            )
            .replaceFirst('///END OF REPOSITORIES', _repositoryString);

        file.writeAsString(modifiedContent);
      }
    } else {
      logger.info('Creating $name repository in repositories file');
      // Create the file if it doesn't exist
      file.writeAsStringSync('''
import '${name.snakeCase}.repository.dart';
///END OF IMPORTS

/// [DataRepositories] is a class that defines the different data repositories.
class DataRepositories {
  DataRepositories._();

  /// [instance] is the singleton instance of [DataRepositories].
  static final DataRepositories instance = DataRepositories._();

$_repositoryString
}
      ''');
    }
  }
}
