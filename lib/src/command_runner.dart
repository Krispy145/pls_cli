import 'package:cli_completion/cli_completion.dart';

import 'commands/add/add.dart';
import 'commands/clean/clean.dart';
import 'commands/clean/paths.dart';
import 'commands/create/create.dart';
import 'commands/deploy/deploy.dart';
import 'commands/find/find.dart';
import 'commands/list/list.dart';
import 'commands/run/run_command.dart';
import 'commands/update.dart';

/// Command runner for the flutter cli
/// used to streamline working with Pls projects & packages
const runnerCommand = "pls";

/// {@template PLSCommandRunner}
/// Command runner for the flutter cli
/// {@endtemplate}
class CommandRunner extends CompletionCommandRunner<void> {
  /// {@macro PLSCommandRunner}
  CommandRunner() : super(runnerCommand, "Streamline working with Pls projects & packages") {
    addCommand(AddCommand());
    addCommand(CreateCommand());
    addCommand(FindCommand());
    addCommand(ListCommand());
    addCommand(UpdateCommand());
    addCommand(DeployCommand());
    addCommand(TogglePathsCommand());
    addCommand(RunCommand());
    addCommand(CleanCommand());
  }
}
