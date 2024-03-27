import 'package:cli_completion/cli_completion.dart';

import 'commands/add/add.dart';
import 'commands/clean/clean.dart';
import 'commands/create/create.dart';
import 'commands/deploy/deploy.dart';
import 'commands/find/find.dart';
import 'commands/list/list.dart';
import 'commands/run/run_command.dart';
import 'commands/update.dart';

/// {@template digitalOasisCommandRunner}
/// Command runner for the flutter cli
/// {@endtemplate}
class CommandRunner extends CompletionCommandRunner<void> {
  /// {@macro digitalOasisCommandRunner}
  CommandRunner() : super("oasis", "Streamline working with Digital Oasis projects & packages") {
    addCommand(AddCommand());
    addCommand(CreateCommand());
    addCommand(FindCommand());
    addCommand(ListCommand());
    addCommand(UpdateCommand());
    addCommand(DeployCommand());
    addCommand(RunCommand());
    addCommand(CleanCommand());
  }
}
