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
  String get description => "Creates a new feature with all the barrel file";

  @override
  String get name => "feature";

  @override
  Future<void> run() async {
    await super.run();
    return runScripts([
      'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
