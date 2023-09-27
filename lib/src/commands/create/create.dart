import 'package:render_cli/src/commands/base.dart';

import 'flutter_app.dart';

/// {@template createCommand}
/// Create a new project.
/// {@endtemplate}
class CreateCommand extends RenderCommand {
  /// {@macro createCommand}
  CreateCommand() {
    addSubcommand(CreateFlutterAppCommand());
  }

  @override
  String get description => 'Create a new project';

  @override
  String get name => 'create';
}
