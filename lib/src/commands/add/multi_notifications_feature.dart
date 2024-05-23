import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import '../brick_command_base.dart';

/// {@template multiNotificationsFeatureCommand}
/// Add multiple notification store features to the app.
/// {@endtemplate}
class MultiNotificationsFeatureCommand extends BrickCommandBase {
  /// {@macro multiNotificationsFeatureCommand}
  MultiNotificationsFeatureCommand() {
    argParser.addOption(
      'project',
      help: 'The name of the project',
      valueHelp: 'project_name',
    );
  }
  @override
  final MasonBundle bundle = multiNotificationsFeatureBundle;

  @override
  String get description => "Add the notifications feature to the app";

  @override
  String get name => "multi_notifications_feature";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final buildRunner = argResults?['runner'] as bool? ?? additionalArgs?['runner'] as bool? ?? false;
    final projectName = argResults?['project'] as String? ?? additionalArgs?['project'] as String?;
    await super.run(
      additionalArgs: {
        'project': projectName,
        'runner': buildRunner,
      },
    );
    return runScripts([
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
    ]);
  }
}
