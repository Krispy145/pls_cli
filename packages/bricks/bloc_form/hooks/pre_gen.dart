import 'package:mason/mason.dart';

/// Map inputs to list
void run(HookContext context) {
  final e = "{{inputs}}".split(",");
  final inputs = e.map((evt) => evt.trim()).toList();
  context.vars = <String, dynamic>{...context.vars, "inputs": inputs};
}
