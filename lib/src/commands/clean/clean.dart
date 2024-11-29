import 'package:lets_yak_cli/src/commands/base.dart';
import 'package:lets_yak_cli/src/commands/clean/pod.dart';

/// {@template clean}
/// Clean the project of various things.
/// {@endtemplate}
class CleanCommand extends LYCommand {
  /// {@macro clean}
  CleanCommand() {
    addSubcommand(PodCleanCommand());
  }

  @override
  String get description => "Clean or reset the project.";

  @override
  String get name => "clean";
}
