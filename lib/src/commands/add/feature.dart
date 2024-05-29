import 'package:oasis_cli/src/commands/base.dart';
import 'package:oasis_cli/src/commands/brick_command_base.dart';
import 'package:oasis_cli/src/utils/helpers.dart';

/// {@template featureCommand}
/// Add a feature to the app.
/// {@endtemplate}
class FeatureCommand extends DOCommand {
  /// FeatureCommand constructor
  FeatureCommand() {
    argParser
      ..addDefaultOptions()
      ..addOption(
        'project',
        help: 'The name of the project',
        valueHelp: 'project_name',
      )
      ..addFlag(
        'ecosystem',
        help: 'Add the ecosystem to the project',
      );
  }
  @override
  String get description => "Creates a new feature for the app";

  @override
  String get name => "feature";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final buildRunner = argResults?['runner'] as bool? ?? false;
    final projectName = argResults?['project'] as String?;
    final isEcoSystem = argResults?['ecosystem'] as bool? ?? false;
    final featureName = argResults?['name'] as String? ??
        logger.prompt(
          prompt: "What is the name of the feature?",
          validator: isValidDirectoryName,
        );
    final dataLayerScript = isEcoSystem ? 'oasis add data_layer --name=$featureName --project=$projectName' : 'oasis add data_layer --name=$featureName --project=$projectName';
    final domainLayerScript = isEcoSystem ? 'oasis add domain_layer --name=$featureName --project=$projectName' : 'oasis add domain_layer --name=$featureName --project=$projectName';
    final presentationLayerScript =
        isEcoSystem ? 'oasis add ecosystem_presentation_layer --name=$featureName --project=$projectName' : 'oasis add presentation_layer --name=$featureName --project=$projectName';

    return runScripts([
      dataLayerScript,
      domainLayerScript,
      presentationLayerScript,
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
      'dart format .',
      'dart fix --apply',
    ]);
  }
}
