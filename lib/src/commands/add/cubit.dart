import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import 'brick_command_base.dart';

/// {@template cubitCommand}
///
/// Add a cubit to a flutter project.
///
/// {@endtemplate}
class CubitCommand extends BrickCommandBase {
  @override
  MasonBundle bundle = cubitBundle;

  /// {@macro cubitCommand}
  CubitCommand() {
    argParser
      ..addFlag(
        "form",
        help: "Creates a form cubit",
      )
      ..addFlag(
        "hasState",
        help: "Whether the cubit has a state class",
      )
      ..addMultiOption(
        "inputs",
        abbr: "i",
        help:
            "A add inputs to a form, this flag can be used multiple times. Only used in a form bloc",
      );

    // If using the prompts separate the events and inputs into a list
    preHooks
      ..add((vars, results, workingDirectory) {
        if (vars.containsKey("inputs") && vars['inputs'] is String) {
          return <String, dynamic>{
            ...vars,
            "inputs": (vars['inputs'] as String)
                .split(",")
                .map((e) => e.trim())
                .toList(),
          };
        }
        return vars;
      })
      ..add((vars, results, workingDirectory) {
        if (results['form'] as bool) {
          return <String, dynamic>{
            ...vars,
            "componentName": (vars["name"] as String)
                    .contains(RegExp("form", caseSensitive: false))
                ? vars["name"]
                : "${vars["name"]}_form",
          };
        }
        return vars;
      });
  }

  @override
  String get description => "Create a cubit";

  @override
  String get name => "cubit";

  @override
  Future<void> run() async {
    if (argResults == null) return;
    if (argResults!['form'] as bool) {
      bundle = cubitFormBundle;
    }
    return super.run();
  }
}
