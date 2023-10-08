import 'dart:io';

import 'package:mason/mason.dart';
import 'package:render_cli/bundles/page_bundle.dart';

import '../../../../render_cli.dart';
import '../brick_command_base.dart';

/// {@template pageCommand}
/// Add a page the app and add the route to the route_generator.
/// {@endtemplate}
class OgPageCommand extends BrickCommandBase {
  /// {@macro pageCommand}
  OgPageCommand() {
    argParser
      ..addFlag("args", help: "Whether the page has Arguments.")
      ..addOption(
        "route-gen-path",
        abbr: "r",
        help: "The path to the route_generator.dart file.",
      )
      ..addOption(
        "generator-index",
        help: "The index of the route generator function.",
      );

    preHooks.add((vars, argResults, outputDir) {
      addToRouteGen(
        pageName: vars['name'] as String,
        hasArguments: vars['args'] as bool,
        outputDir: outputDir ?? Directory.current.path,
        pathToRouteGen: argResults['route-gen-path'] as String?,
        selectedGeneratorIndex: argResults['generator-index'] as String?,
      );
      return vars;
    });
  }
  @override
  MasonBundle get bundle => pageBundle;

  @override
  String get description => "Using navigator 1.0 create a new page and add it to the route generator.";

  @override
  String get name => "og-page";
}
