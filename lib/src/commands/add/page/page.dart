import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:mason/mason.dart' as mason;
import 'package:render_cli/bundles/_bundles.dart';
import 'package:render_cli/src/commands/add/brick_command_base.dart';
import 'package:render_cli/src/utils/process_log.dart';

/// {@template pageCommand}
/// Add a page to a flutter project and add the route to the router config
///
/// Uses AutoRoute
/// {@endtemplate}
class PageCommand extends BrickCommandBase {
  /// {@macro pageCommand}
  PageCommand() : super() {
    preHooks.add((vars, argResults, outputDir) async {
      final name = vars['name'] as String;
      final template = _routeTemplate(name);
      if (!Platform.isMacOS) {
        logger
          ..info("===================================================".green)
          ..info("Add the following to your route config: \n$template")
          ..info("===================================================".green);
      } else {
        logger
          ..info("===================================================".green)
          ..info("📋 Copying route to clipboard".green.bold)
          ..info("Add it to the correct place in your route config.")
          ..info("===================================================".green);
        await runShellCommand("echo '$template' | pbcopy");
      }
      return vars;
    });
  }
  @override
  mason.MasonBundle get bundle => goRouterPageBundle;

  @override
  String get description => "Add a page to a flutter project using go router";

  @override
  String get name => "page";
}

String _routeTemplate(String name) =>
    'AutoRoute(path: "/${name.paramCase}", page: ${name.pascalCase}Route.page)';
