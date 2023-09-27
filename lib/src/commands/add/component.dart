import 'package:mason/mason.dart';

import '../../../bundles/_bundles.dart';
import 'brick_command_base.dart';

/// {@template componentCommand}
///
/// Add a component to flutter project
///
/// {@endtemplate}
class ComponentCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = componentBundle;

  @override
  String get description => "Creates a new component";

  @override
  String get name => "component";
}
