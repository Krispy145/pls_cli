import 'dart:io';

import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template modelCommand}
///
/// Add a model to flutter project
///
/// {@endtemplate}
class ModelCommand extends BrickCommandBase {
  /// ModelCommand Constructor
  ModelCommand() {
    argParser.addFlag(
      "serializable",
      help: "Whether the model is json serializable",
    );
  }
  @override
  final MasonBundle bundle = modelBundle;

  @override
  String get description => "Creates a new model";

  @override
  String get name => "model";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    if (argResults?['path'] == null) {
      // Get the current directory
      final currentDirectory = Directory.current;

      // Check if the current directory is 'models'
      if (currentDirectory.path.endsWith('models')) {
        // Run the brick directly in the 'models' directory
        await super.run();
      } else {
        // Create a directory using the current directory path and change to that directory
        const modelName = 'models'; // Change this to your desired model name
        final modelDirectory = Directory('${currentDirectory.path}/$modelName');

        // Check if the directory already exists
        if (!modelDirectory.existsSync()) {
          modelDirectory.createSync();
        }

        // Change to the model directory
        Directory.current = modelDirectory;

        // Run the brick in the new model directory
        await super.run();
      }
      return runScripts(
        ['flutter pub run build_runner build --delete-conflicting-outputs'],
      );
    } else {
      await super.run();
    }
  }
}
