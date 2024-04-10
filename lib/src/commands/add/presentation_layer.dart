import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template presentationCommand}
/// Add a presentation layer for the app.
/// {@endtemplate}
class PresentationLayerCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = presentationLayerBundle;

  @override
  String get description => "Creates a new presentation layer for the app";

  @override
  String get name => "presentation_layer";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    await super.run();
    return runScripts([
      'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
