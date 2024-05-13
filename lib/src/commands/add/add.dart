import 'package:oasis_cli/src/commands/add/auth.dart';
import 'package:oasis_cli/src/commands/add/ecosystem_presentation_layer.dart';
import 'package:oasis_cli/src/commands/base.dart';

import 'component.dart';
import 'data_layer.dart';
import 'domain_layer.dart';
import 'feature.dart';
import 'logger.dart';
import 'model.dart';
import 'multi_notifications_feature.dart';
import 'notifications_feature.dart';
import 'presentation_layer.dart';
import 'structures.dart';

/// {@template addCommand}
/// Add various parts of the app.
/// {@endtemplate}
class AddCommand extends DOCommand {
  /// {@macro addCommand}
  AddCommand() {
    addSubcommand(ComponentCommand());
    addSubcommand(FeatureCommand());
    addSubcommand(AuthCommand());
    addSubcommand(StructuresCommand());
    addSubcommand(DataLayerCommand());
    addSubcommand(DomainLayerCommand());
    addSubcommand(PresentationLayerCommand());
    addSubcommand(EcosystemPresentationLayerCommand());
    addSubcommand(NotificationsFeatureCommand());
    addSubcommand(MultiNotificationsFeatureCommand());
    addSubcommand(LoggerFeatureCommand());
    addSubcommand(ModelCommand());
  }
  @override
  String get description => "Add parts the app";

  @override
  String get name => "add";
}
