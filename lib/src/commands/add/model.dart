import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import 'brick_command_base.dart';

/// {@template modelCommand}
/// Add a new model to a flutter project.
/// {@endtemplate}
class ModelCommand extends BrickCommandBase {
  /// {@macro modelCommand}
  ModelCommand() {
    argParser.addFlag(
      "serializable",
      help: "Whether the model is json serializable",
    );
  }
  @override
  MasonBundle get bundle => modelBundle;

  @override
  String get description => "Create a new model";

  @override
  String get name => "model";
}
