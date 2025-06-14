import 'package:pls_cli/src/commands/base.dart';
import 'package:pls_cli/src/commands/create/ecosystem.dart';
import 'package:pls_cli/src/commands/create/package.dart';

import 'app.dart';

/// {@template createCommand}
/// Create a new project.
/// {@endtemplate}
class CreateCommand extends PLSCommand {
  /// {@macro createCommand}
  CreateCommand() {
    addSubcommand(CreateAppCommand());
    addSubcommand(PackageCommand());
    addSubcommand(EcosystemCommand());
  }

  @override
  String get description => 'Create something new...';

  @override
  String get name => 'create';
}
