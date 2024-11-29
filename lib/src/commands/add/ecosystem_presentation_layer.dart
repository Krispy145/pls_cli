import 'dart:io';

import 'package:lets_yak_cli/src/utils/helpers.dart';
import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template ecosystemPresentationCommand}
/// Add a ecosystemPresentation layer for the app.
/// {@endtemplate}
class EcosystemPresentationLayerCommand extends BrickCommandBase {
  /// [EcosystemPresentationLayerCommand] constructor
  EcosystemPresentationLayerCommand() {
    argParser.addOption(
      'project',
      help: 'The name of the project',
      valueHelp: 'project_name',
    );
  }
  @override
  final MasonBundle bundle = ecosystemPresentationLayerBundle;

  @override
  String get description => "Creates a new Ecosystem Presentation layer for the app";

  @override
  String get name => "ecosystem_presentation_layer";

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
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
