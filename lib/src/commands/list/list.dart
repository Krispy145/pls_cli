import 'package:pls_cli/src/commands/base.dart';
import 'package:pls_cli/src/commands/list/features.dart';

/// {@template listCommand}
/// List various aspects of a flutter project.
///
/// May not need to call this manually. Used in extensions.
/// {@endtemplate}
class ListCommand extends PLSCommand {
  /// {@macro listCommand}
  ListCommand() {
    addSubcommand(ListFeaturesCommand());
  }
  @override
  String get description => "List various aspects of a flutter project.";

  @override
  String get name => "list";
}
