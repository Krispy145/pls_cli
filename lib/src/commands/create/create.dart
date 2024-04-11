import 'package:oasis_cli/src/commands/base.dart';
import 'package:oasis_cli/src/commands/create/managed_app.dart';
import 'package:oasis_cli/src/commands/create/package.dart';

import 'app.dart';

/// {@template createCommand}
/// Create a new project.
/// {@endtemplate}
class CreateCommand extends UnpackCommand {
  /// {@macro createCommand}
  CreateCommand() {
    addSubcommand(CreateAppCommand());
    addSubcommand(PackageCommand());
    addSubcommand(ManagedAppCommand());
  }

  @override
  String get description => 'Create something new...';

  @override
  String get name => 'create';
}
