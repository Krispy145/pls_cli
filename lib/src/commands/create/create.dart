import 'package:oasis_cli/src/commands/base.dart';

import 'app.dart';

/// {@template createCommand}
/// Create a new project.
/// {@endtemplate}
class CreateCommand extends UnpackCommand {
  /// {@macro createCommand}
  CreateCommand() {
    addSubcommand(CreateAppCommand());
  }

  @override
  String get description => 'Create a new project';

  @override
  String get name => 'create';
}
