import 'package:mason/mason.dart';

import '../brick_command_base.dart';

/// {@template featureCommand}
/// Add a feature to the app.
/// {@endtemplate}
class FeatureCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = const MasonBundle(
    name: 'Feature',
    description: "Creates a new feature for the app",
    version: '0.0.1',
  );

  @override
  String get description => "Creates a new feature for the app";

  @override
  String get name => "feature";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final featureName = argResults?['name'] as String? ?? logger.prompt(prompt: "What is the name of the feature?");

    return runScripts([
      "oasis add data_layer --name $featureName",
      "oasis add domain_layer --name $featureName",
      "oasis add presentation_layer --name $featureName",
      'oasis add logger --name $featureName',
      'dart format .',
      'dart fix --apply',
    ]);
  }
}
