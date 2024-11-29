import 'dart:async';
import 'dart:io';

import 'package:lets_yak_cli/src/commands/base.dart';

import '../../utils/helpers.dart';

/// {@template projectRootCommand}
/// Find and print the path to the route generator.
/// {@endtemplate}
class ProjectRootCommand extends LYCommand {
  /// {@macro projectRootCommand}
  ProjectRootCommand() {
    argParser.addOption(
      "start-dir",
      help: "The directory to start looking from",
      defaultsTo: Directory.current.absolute.toString(),
    );
  }
  @override
  String get description => "Find and print the project root path. Looks for the closet pubspec.yaml";

  @override
  String get name => "project-root";

  @override
  FutureOr<void> run() {
    var startDir = Directory.current;
    final results = argResults;
    if (results != null && results["start-dir"] != null) {
      startDir = Directory(results["start-dir"] as String);
    }
    try {
      final root = findProjectRoot(startDir);
      stdout.write(root.absolute.path);
    } catch (e) {
      stderr.writeln(e);
    }
  }
}
