import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template componentCommand}
///
/// Add a component to flutter project
///
/// {@endtemplate}
class ComponentCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = componentBundle;

  @override
  String get description => "Creates a new component";

  @override
  String get name => "component";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    if (argResults?['path'] == null) {
      // Get the current directory
      final currentDirectory = Directory.current;

      // Check if the current directory is 'components'
      if (currentDirectory.path.endsWith('components')) {
        // Run the brick directly in the 'components' directory
        await super.run();
      } else {
        // Create a directory using the current directory path and change to that directory
        const componentName = 'components'; // Change this to your desired component name
        final componentDirectory = Directory('${currentDirectory.path}/$componentName');

        // Check if the directory already exists
        if (!componentDirectory.existsSync()) {
          componentDirectory.createSync();
        }

        // Change to the component directory
        Directory.current = componentDirectory;
        logger.info('Changed working directory to: ${componentDirectory.path}'.blue);

        // Run the brick in the new component directory
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
