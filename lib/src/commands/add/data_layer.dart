import 'dart:io';

import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import 'brick_command_base.dart';

/// {@template dataCommand}
/// Add a data layer for the app.
/// {@endtemplate}
class DataLayerCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = dataLayerBundle;

  @override
  String get description => "Creates a new data layer for the app";

  @override
  String get name => "data_layer";

  @override
  Future<void> run() async {
    _addRepositoriesFile();
    await super.run();
    return runScripts([
      'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }

  void _addRepositoriesFile() {
    final currentDirectory = Directory.current;
    final _featureName = argResults?['name'] as String? ??
        logger.prompt(prompt: "What is the name of the feature?");
    if (currentDirectory.existsSync()) {
      final file = File.fromUri(
          currentDirectory.uri.resolve('repositories/_repositories.dart'),);
      final fileExists = file.existsSync();
      final _repositoryString = '''
/// [${_featureName.camelCase}] is the [${_featureName.pascalCase}DataRepository] instance.
  final ${_featureName.pascalCase}DataRepository ${_featureName.camelCase} = ${_featureName.pascalCase}DataRepository();

  ///END OF REPOSITORIES
  ''';

      if (fileExists) {
        logger.info('$_featureName repository already exists');
        // Read the existing file content
        final fileContent = file.readAsStringSync();

        // Check if the content already contains the repository string
        if (!fileContent.contains(_repositoryString)) {
          logger.info('Adding $_featureName repository to repositories file');

          // Modify the content and write it back
          final modifiedContent = fileContent
              .replaceFirst('///END OF IMPORTS',
                  "import '${_featureName.snakeCase}.repository.dart';\n///END OF IMPORTS",)
              .replaceFirst('///END OF REPOSITORIES', _repositoryString);

          file.writeAsString(modifiedContent);
        }
      } else {
        logger.info('Creating $_featureName repository in repositories file');
        // Create the file if it doesn't exist
        file.writeAsStringSync('''
import '${_featureName.snakeCase}.repository.dart';
///END OF IMPORTS

/// [SourceTypes] is an enum that defines the different data sources.
enum SourceTypes {
  /// [api] is the remote data source.
  api,

  /// [local] is the local data source.
  local,

  /// [firestore] is the firestore data source.
  firestore,

  /// [secure] is the secure data source.
  secure;
}

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
}
