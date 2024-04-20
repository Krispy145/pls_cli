import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template domainCommand}
/// Add a domain layer for the app.
/// {@endtemplate}
class DomainLayerCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = domainLayerBundle;

  @override
  String get description => "Creates a new domain layer for the app";

  @override
  String get name => "domain_layer";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final buildRunner = argResults?['runner'] as bool? ?? false;
    await super.run();
    return runScripts([
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
