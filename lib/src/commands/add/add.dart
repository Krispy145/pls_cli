import 'package:render_cli/src/commands/add/assets.dart';
import 'package:render_cli/src/commands/add/fonts.dart';
import 'package:render_cli/src/commands/add/page/og_page.dart';
import 'package:render_cli/src/commands/add/page/page.dart';
import 'package:render_cli/src/commands/base.dart';

import 'bloc.dart';
import 'bloc_event.dart';
import 'component.dart';
import 'cubit.dart';
import 'feature.dart';
import 'file.dart';
import 'form_input/form_input.dart';
import 'model.dart';

/// {@template addCommand}
/// Add various parts the app.
/// {@endtemplate}
class AddCommand extends RenderCommand {
  /// {@macro addCommand}
  AddCommand() {
    addSubcommand(FontsCommand());
    addSubcommand(ComponentCommand());
    addSubcommand(BlocCommand());
    addSubcommand(CubitCommand());
    addSubcommand(FeatureCommand());
    addSubcommand(LoggerFeatureCommand());
    addSubcommand(ModelCommand());
    addSubcommand(OgPageCommand());
    addSubcommand(PageCommand());
    addSubcommand(FileCommand());
    addSubcommand(BlocEventCommand());
    addSubcommand(FormInputCommand());
    addSubcommand(AssetsCommand());
  }
  @override
  String get description => "Add parts the app";

  @override
  String get name => "add";
}
