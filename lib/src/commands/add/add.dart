import 'package:render_cli/src/commands/add/assets.dart';
import 'package:render_cli/src/commands/add/fonts.dart';
import 'package:render_cli/src/commands/add/notifications_feature.dart';

import 'package:render_cli/src/commands/base.dart';

import 'component.dart';

import 'feature.dart';

import 'model.dart';

/// {@template addCommand}
/// Add various parts the app.
/// {@endtemplate}
class AddCommand extends RenderCommand {
  /// {@macro addCommand}
  AddCommand() {
    addSubcommand(FontsCommand());
    addSubcommand(ComponentCommand());
    addSubcommand(FeatureCommand());
    addSubcommand(NotificationsFeatureCommand());
    addSubcommand(LoggerFeatureCommand());
    addSubcommand(ModelCommand());
    addSubcommand(AssetsCommand());
  }
  @override
  String get description => "Add parts the app";

  @override
  String get name => "add";
}
