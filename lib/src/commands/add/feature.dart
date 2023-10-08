import 'dart:io';

import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import 'brick_command_base.dart';

/// {@template featureCommand}
/// Add a feature structure to a flutter project.
/// {@endtemplate}
class FeatureCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = featureBundle;

  @override
  String get description => "Creates a new feature for the app";

  @override
  String get name => "feature";

  @override
  Future<void> run() async {
    await super.run();
    // parse the event name
    final featureName = argResults?['name'] as String? ?? logger.prompt(prompt: "What is the name of the logger feature?");
    // Call the runInLibDirectory function to change the working directory to "lib"
    runInLibDirectory(() => replaceLoggerFeatureString(featureName));

    return runScripts([
      'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }

  /// Add the Feature to the Logger to be used in the app
  void replaceLoggerFeatureString(String name) {
    // Define the string to replace
    const searchString = '///LOGGER FEATURE END';

    // Define the replacement string
    final replacementString = 'static final LoggerFeature ${name.camelCase} = LoggerFeature("${name.constantCase}", true);\n///LOGGER FEATURE END';

    // Get the current working directory
    final currentDirectory = Directory.current;

    // Change the working directory to "utils"
    final utilsDirectory = Directory.fromUri(currentDirectory.uri.resolve('utils'));

    // Read the content of the logger feature file
    final loggerFeatureFile = File.fromUri(utilsDirectory.uri.resolve('logger_features.dart'));
    var fileContent = loggerFeatureFile.readAsStringSync();

    // Replace the string
    fileContent = fileContent.replaceFirst(searchString, replacementString);

    // Write the modified content back to the file
    loggerFeatureFile.writeAsStringSync(fileContent);
  }
}

class LoggerFeatureCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = const MasonBundle(name: 'Logger', description: "Creates a new logger feature for the feature", version: '0.0.1');

  @override
  String get description => "Creates a new logger feature for the feature";

  @override
  String get name => "logger";

  @override
  Future<void> run() {
    // parse the event name
    final featureName = argResults?['name'] as String? ?? logger.prompt(prompt: "What is the name of the logger feature?");
    // Call the runInLibDirectory function to change the working directory to "lib"
    runInLibDirectory(() => replaceLoggerFeatureString(featureName));
    return runScripts([
      'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }

  /// Add the Feature to the Logger to be used in the app
  void replaceLoggerFeatureString(String name) {
    // Define the string to replace
    const searchString = '///LOGGER FEATURE END';

    // Define the replacement string
    final replacementString = 'static final LoggerFeature ${name.camelCase} = LoggerFeature("${name.constantCase}", true);\n///LOGGER FEATURE END';

    // Get the current working directory
    final currentDirectory = Directory.current;

    // Change the working directory to "utils"
    final utilsDirectory = Directory.fromUri(currentDirectory.uri.resolve('utils'));

    // Read the content of the logger feature file
    final loggerFeatureFile = File.fromUri(utilsDirectory.uri.resolve('logger_features.dart'));
    var fileContent = loggerFeatureFile.readAsStringSync();

    // Replace the string
    fileContent = fileContent.replaceFirst(searchString, replacementString);

    // Write the modified content back to the file
    loggerFeatureFile.writeAsStringSync(fileContent);
  }
}
