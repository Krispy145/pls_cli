import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template authCommand}
/// Add a auth layer for the app.
/// {@endtemplate}
class AuthCommand extends BrickCommandBase {
  /// FeatureCommand constructor
  AuthCommand() {
    argParser
      ..addFlag(
        'auth',
        help: 'Add Authentication to the project',
      )
      ..addFlag(
        'silent',
        help: 'Add Silent Authentication to the project',
      )
      ..addFlag(
        'both',
        help: 'Add Silent and User Authentication to the project',
      );
  }
  @override
  final MasonBundle bundle = authBundle;

  @override
  String get description => "Adds authentication to the app with auth guard with auth type choices";

  @override
  String get name => "auth";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final buildRunner = argResults?['runner'] as bool? ?? false;
    final auth = argResults?['auth'] as bool? ?? false;
    final silent = argResults?['silent'] as bool? ?? false;
    final silentAuth = argResults?['both'] as bool? ?? false;
    await super.run(
      additionalArgs: {
        'auth': auth,
        'silent': silent,
        'both': silentAuth,
      },
    );
    return runScripts([
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
