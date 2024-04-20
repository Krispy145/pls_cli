import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template notificationsFeatureCommand}
/// Add a notifications feature to the app.
/// {@endtemplate}
class NotificationsFeatureCommand extends BrickCommandBase {
  /// {@macro notificationsFeatureCommand}
  NotificationsFeatureCommand() {
    argParser
      ..addOption(
        'store',
        abbr: 's',
        help: 'The store of the notifications feature.',
        valueHelp: 'local_notifications_store',
        defaultsTo: 'local_notifications_store',
      )
      ..addOption(
        'store_route',
        abbr: 'r',
        help: 'The store route of the notifications file.',
        valueHelp: 'local_store',
        defaultsTo: 'local_store',
      )
      ..addOption(
        'is_push',
        help: 'Is this a push notification store?',
        valueHelp: 'false',
        defaultsTo: 'false',
      );
  }
  @override
  final MasonBundle bundle = notificationsFeatureBundle;

  @override
  String get description => "Add the notifications feature to the app";

  @override
  String get name => "notifications_feature";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final buildRunner = argResults?['runner'] as bool? ?? false;
    await super.run();
    return runScripts([
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
