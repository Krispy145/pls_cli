import 'package:pls_cli/src/commands/base.dart';
import 'package:pls_cli/src/commands/clean/pod.dart';

/// {@template clean}
/// Clean the project of various things.
/// {@endtemplate}
class CleanCommand extends PLSCommand {
  /// {@macro clean}
  CleanCommand() {
    addSubcommand(PodCleanCommand());
  }

  @override
  String get description => "Clean or reset the project.";

  @override
  String get name => "clean";
}
