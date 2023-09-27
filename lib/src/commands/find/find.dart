import 'package:args/command_runner.dart';
import 'package:render_cli/src/commands/find/project_root.dart';

/// {@template findCommand}
/// Find various aspects of a flutter project.
///
/// May not need to call this manually. Used in extensions.
/// {@endtemplate}
class FindCommand extends Command<void> {
  /// {@macro findCommand}
  FindCommand() {
    addSubcommand(ProjectRootCommand());
  }
  @override
  String get description => "Find various aspects of a flutter project.";

  @override
  String get name => "find";
}
