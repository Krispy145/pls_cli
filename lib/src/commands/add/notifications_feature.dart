import 'dart:io';

import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import 'brick_command_base.dart';

/// {@template featureCommand}
/// Add a notifications feature to the app.
/// {@endtemplate}
class NotificationsFeatureCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = notificationsFeatureBundle;

  @override
  String get description => "Add the notifications feature to the app";

  @override
  String get name => "notifications_feature";

  @override
  Future<void> run() async {
    await super.run();
    return runScripts([
      'flutter pub run build_runner build --delete-conflicting-outputs',
      'rn add logger --name ${argResults?['name'] as String}',
    ]);
  }
}
