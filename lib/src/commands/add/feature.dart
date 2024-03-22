import 'package:mason/mason.dart';
import 'brick_command_base.dart';

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
  Future<void> run() async {
    final featureName = argResults?['name'] as String? ?? logger.prompt(prompt: "What is the name of the feature?");

    await runInLibDirectory(
      () => runScripts(["up add data_layer --name $featureName"]),
      extensionPath: "data",
    );
    await runInLibDirectory(
      () => runScripts(["up add domain_layer --name $featureName"]),
      extensionPath: "domain",
    );
    await runInLibDirectory(
      () => runScripts(["up add presentation_layer --name $featureName"]),
      extensionPath: "presentation",
    );

    return runScripts([
      'up add logger --name $featureName',
      'dart format .',
      'dart fix --apply',
    ]);
  }
}
