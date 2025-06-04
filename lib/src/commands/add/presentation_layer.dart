import 'dart:io';

import 'package:pls_cli/src/utils/helpers.dart';
import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template presentationCommand}
/// Add a presentation layer for the app.
/// {@endtemplate}
class PresentationLayerCommand extends BrickCommandBase {
  /// [PresentationLayerCommand] constructor
  PresentationLayerCommand() {
    argParser.addOption(
      'project',
      help: 'The name of the project',
      valueHelp: 'project_name',
    );
  }
  @override
  final MasonBundle bundle = presentationLayerBundle;

  @override
  String get description => "Creates a new presentation layer for the app";

  @override
  String get name => "presentation_layer";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final buildRunner = argResults?['runner'] as bool? ?? false;
    final projectName = argResults?['project'] as String?;
    await super.run();
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
      'pls add logger --name=$name',
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
