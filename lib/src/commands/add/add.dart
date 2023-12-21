import 'dart:ffi';

import 'package:render_cli/src/commands/base.dart';

import 'assets.dart';
import 'component.dart';
import 'data_layer.dart';
import 'domain_layer.dart';
import 'feature.dart';
import 'fonts.dart';
import 'logger.dart';
import 'model.dart';
import 'multi_notifications_feature.dart';
import 'notifications_feature.dart';
import 'presentation_layer.dart';
import 'structures.dart';

/// {@template addCommand}
/// Add various parts the app.
/// {@endtemplate}
class AddCommand extends RenderCommand {
  /// {@macro addCommand}
  AddCommand() {
    addSubcommand(FontsCommand());
    addSubcommand(ComponentCommand());
    addSubcommand(FeatureCommand());
    addSubcommand(StructuresCommand());
    addSubcommand(DataLayerCommand());
    addSubcommand(DomainLayerCommand());
    addSubcommand(PresentationLayerCommand());
    addSubcommand(NotificationsFeatureCommand());
    addSubcommand(MultiNotificationsFeatureCommand());
    addSubcommand(LoggerFeatureCommand());
    addSubcommand(ModelCommand());
    addSubcommand(AssetsCommand());
  }
  @override
  String get description => "Add parts the app";

  @override
  String get name => "add";
}
