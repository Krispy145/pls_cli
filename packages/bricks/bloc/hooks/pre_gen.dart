import 'package:mason/mason.dart';

/// only used for testing the bricks separately.
void run(HookContext context) {
  final e = "{{events}}".split(",");
  final events = e.map((evt) => evt.trim()).toList();
  context.vars = <String, dynamic>{...context.vars, "events": events};
}
