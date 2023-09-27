import 'dart:async';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:collection/collection.dart';
import 'package:render_cli/src/commands/base.dart';

import '../../../render_cli.dart';

/// {@template list.route_gen}
/// List the functions found in a file.
/// {@endtemplate}
class RouteGeneratorsCommand extends RenderCommand {
  /// {@macro list.route_gen}
  RouteGeneratorsCommand() {
    argParser.addOption(
      "path",
      abbr: "p",
      help: "Path to the route_generator.dart",
      mandatory: true,
    );
  }
  @override
  String get description => "List the route generators in a given file.";

  @override
  String get name => "route-generators";

  @override
  FutureOr<void> run() {
    final result = argResults;
    if (result == null || result["path"] == null || result["path"] is! String) {
      throw Exception("No path argument given");
    }
    try {
      final path = result["path"] as String;
      final parsedFile = parseFile(
        path: path,
        featureSet: FeatureSet.latestLanguageVersion(),
        throwIfDiagnostics: false,
      );
      final routers = listRouters(parsedFile: parsedFile);

      logger.info(routers.mapIndexed((i, e) => "[$i] ${e.name}").join(","));
    } catch (e) {
      logger.err(e.toString());
    }
  }
}
