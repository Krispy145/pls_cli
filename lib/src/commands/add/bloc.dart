import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import 'brick_command_base.dart';

/// {@template blocCommand}
/// Create a new bloc with either the form template or the state template.
/// {@endtemplate}
class BlocCommand extends BrickCommandBase {
  @override
  MasonBundle bundle = blocBundle;

  /// {@macro blocCommand}
  BlocCommand() {
    argParser
      ..addFlag("form", help: "Creates a form bloc")
      ..addMultiOption(
        "events",
        abbr: "e",
        help: "Add events, this flag can be used multiple times. Not used in a form bloc",
      )
      ..addMultiOption(
        "inputs",
        abbr: "i",
        help: "A add inputs to a form, this flag can be used multiple times. Only used in a form bloc",
      );

    preHooks
      ..add((vars, results, workingDirectory) {
        if (results['form'] as bool) {
          return <String, dynamic>{
            ...vars,
            "componentName": (vars["name"] as String).contains(RegExp("form", caseSensitive: false)) ? vars["name"] : "${vars["name"]}_form",
          };
        }
        return vars;
      })
      // If using the prompts separate the events and inputs into a list
      ..add((vars, results, workingDirectory) {
        if (vars.containsKey("events") && vars['events'] is String) {
          return <String, dynamic>{
            ...vars,
            "events": (vars['events'] as String).split(",").map((e) => e.trim()).toList(),
          };
        }
        return vars;
      })
      ..add((vars, results, workingDirectory) {
        if (vars.containsKey("inputs") && vars['inputs'] is String) {
          return <String, dynamic>{
            ...vars,
            "inputs": (vars['inputs'] as String).split(",").map((e) => e.trim()).toList(),
          };
        }
        return vars;
      });
  }

  @override
  String get description => "Creates a new bloc";

  @override
  String get name => "bloc";

  @override
  Future<void> run() async {
    if (argResults == null) return;
    if (argResults!['form'] as bool) {
      bundle = blocFormBundle;
    }
    return super.run();
  }
}
