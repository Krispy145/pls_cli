import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import 'brick_command_base.dart';

/// {@template authCommand}
/// Add a auth layer for the app.
/// {@endtemplate}
class AuthCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = authBundle;

  @override
  String get description => "Adds authentication to the app with auth guard";

  @override
  String get name => "auth";

  @override
  Future<void> run() async {
    await super.run();
    return runScripts([
      'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
