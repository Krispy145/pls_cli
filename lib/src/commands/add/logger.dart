import 'dart:io';

import 'package:mason/mason.dart';
import 'brick_command_base.dart';

/// {@template loggerCommand}
/// LoggerFeatureCommand for adding a logger feature to the app
/// {@endtemplate}
class LoggerFeatureCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = const MasonBundle(
      name: 'Logger',
      description: "Creates a new logger feature for the feature",
      version: '0.0.1',);

  @override
  String get description => "Creates a new logger feature for the feature";

  @override
  String get name => "logger";

  @override
  Future<void> run() async {
    // parse the event name
    final featureName = argResults?['name'] as String? ??
        logger.prompt(prompt: "What is the name of the logger feature?");
    // Call the runInLibDirectory function to change the working directory to "lib"
    await runInLibDirectory(() => replaceLoggerFeatureString(featureName),
        extensionPath: "utils",);
    return runScripts([
      'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }

  /// Add the Feature to the Logger to be used in the app
  Future<void> replaceLoggerFeatureString(String name) async {
    // Define the string to replace
    const searchString = '///LOGGER FEATURE END';

    // Define the replacement string
    final replacementString =
        '/// ${name.pascalCase} logger feature.\nstatic final LoggerFeature ${name.camelCase} = LoggerFeature("${name.constantCase}", true);\n///LOGGER FEATURE END';

    // Get the current working directory
    final currentDirectory = Directory.current;

    // Read the content of the logger feature file
    final loggerFeatureFile =
        File.fromUri(currentDirectory.uri.resolve('logger_features.dart'));
    var fileContent = loggerFeatureFile.readAsStringSync();

    // Replace the string
    if (!fileContent.contains(replacementString)) {
      fileContent = fileContent.replaceFirst(searchString, replacementString);
    }

    // Write the modified content back to the file
    loggerFeatureFile.writeAsStringSync(fileContent);
  }
}
