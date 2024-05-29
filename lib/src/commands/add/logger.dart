import 'dart:io';

import 'package:mason/mason.dart';
import 'package:oasis_cli/src/commands/base.dart';
import 'package:oasis_cli/src/commands/brick_command_base.dart';
import 'package:oasis_cli/src/utils/helpers.dart';

/// {@template loggerCommand}
/// LoggerFeatureCommand for adding a logger feature to the app
/// {@endtemplate}
class LoggerFeatureCommand extends DOCommand {
  /// LoggerFeatureCommand constructor
  LoggerFeatureCommand() {
    argParser.addDefaultOptions();
  }

  @override
  String get description => "Creates a new logger feature for the feature";

  @override
  String get name => "logger";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final buildRunner = argResults?['runner'] as bool? ?? false;
    final path = argResults?['path'] as String?;
    // parse the event name
    final featureName = argResults?['name'] as String? ??
        logger.prompt(
          prompt: "What is the name of the logger feature?",
          validator: isValidDirectoryName,
        );
    if (path != null) {
      await replaceLoggerFeatureString(featureName, '$path/utils');
    } else {
      // Call the runInLibDirectory function to change the working directory to "lib"
      await runInLibDirectory(
        () => replaceLoggerFeatureString(featureName, Directory.current.path),
        extensionPath: "utils",
      );
    }
    return runScripts([
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }

  /// Add the Feature to the Logger to be used in the app
  Future<void> replaceLoggerFeatureString(String name, String path) async {
    // Define the string to replace
    const searchString = '/// LOGGER FEATURE END';

    // Define the replacement string
    final replacementString = '/// [${name.camelCase}] is the ${name.pascalCase} feature\n ${name.camelCase},\n\n /// LOGGER FEATURE END';

    // Get the current working directory
    final currentDirectory = Directory(path);

    // Read the content of the logger feature file
    final loggerFeatureFile = File.fromUri(currentDirectory.uri.resolve('loggers.dart'));
    var fileContent = loggerFeatureFile.readAsStringSync();

    // Replace the string
    if (!fileContent.contains("[${name.camelCase}] is the ${name.pascalCase} feature\n ${name.camelCase}")) {
      fileContent = fileContent.replaceFirst(searchString, replacementString);
    }

    // Write the modified content back to the file
    loggerFeatureFile.writeAsStringSync(fileContent);
  }
}
