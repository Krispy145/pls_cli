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
        'project',
        help: 'The name of the project',
        valueHelp: 'project_name',
      )
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
      ..addFlag(
        'is_push',
        help: 'Is this a push notification store?',
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
    final buildRunner = argResults?['runner'] as bool? ?? additionalArgs?['runner'] as bool? ?? false;
    final projectName = argResults?['project'] as String? ?? additionalArgs?['project'] as String?;
    await super.run(
      additionalArgs: {
        'store': argResults?['store'] as String? ?? additionalArgs?['store'] as String?,
        'store_route': argResults?['store_route'] as String? ?? additionalArgs?['store_route'] as String?,
        'is_push': argResults?['is_push'] as bool? ?? additionalArgs?['is_push'] as bool?,
        'project': projectName,
        'runner': buildRunner,
      },
    );
    return runScripts([
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
