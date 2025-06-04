import 'dart:io';

import 'package:pls_cli/src/utils/helpers.dart';
import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template domainCommand}
/// Add a domain layer for the app.
/// {@endtemplate}
class DomainLayerCommand extends BrickCommandBase {
  /// [DomainLayerCommand] constructor
  DomainLayerCommand() {
    argParser.addOption(
      'project',
      help: 'The name of the project',
      valueHelp: 'project_name',
    );
  }
  @override
  final MasonBundle bundle = domainLayerBundle;

  @override
  String get description => "Creates a new domain layer for the app";

  @override
  String get name => "domain_layer";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final buildRunner = argResults?['runner'] as bool? ?? false;
    final projectName = argResults?['project'] as String?;
    final _featureName = argResults?['name'] as String? ??
        logger.prompt(
          prompt: "What is the name of the data_layer?",
          validator: isValidDirectoryName,
        );
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
      'pls add logger --name=$_featureName',
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
