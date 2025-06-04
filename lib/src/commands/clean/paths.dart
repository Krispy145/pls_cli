import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:pls_cli/src/commands/base.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

/// {@template togglePathsCommand}
/// Toggle dependency paths between local and remote.
/// {@endtemplate}
class TogglePathsCommand extends PLSCommand {
  /// [pathTypes] available for toggling.
  static const pathTypes = ["local", "remote"];

  /// [TogglePathsCommand] constructor.
  TogglePathsCommand() {
    argParser
      ..addOption(
        "type",
        abbr: "t",
        help: "Specify the path type (local or remote).",
      )
      ..addOption(
        "local-path",
        abbr: "l",
        help: "Specify the base local path for packages (only required for local).",
      );
  }

  @override
  String get description => "Toggle dependency paths between local and remote.";

  @override
  String get name => "toggle-paths";

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) {
      logger.err("No arguments provided.");
      return;
    }

    // Verify the user is in the root folder.
    if (!Directory.current.listSync().any((e) => e is File && p.basename(e.path) == "pubspec.yaml")) {
      logger.err("You must be in the root folder of your project.");
      return;
    }

    // Determine the path type
    final pathType = _getPathType(results);
    if (pathType == null) return;

    // Get the local path if needed
    String? localPathPrefix;
    if (pathType == "local") {
      localPathPrefix = _getLocalPath(results);
      if (localPathPrefix == null) return;
    }

    // Hardcoded GitHub base path for remote packages
    const githubBaseUrl = "https://github.com/pls/packages.git";

    // Search for pubspec.yaml files
    final pubspecFiles = Directory.current.listSync(recursive: true).where((file) => file is File && file.path.endsWith("pubspec.yaml")).toList();

    if (pubspecFiles.isEmpty) {
      logger.err("No pubspec.yaml files found in the workspace.");
      return;
    }

    logger.info("Found ${pubspecFiles.length} pubspec.yaml files.");
    for (final file in pubspecFiles) {
      await togglePaths(file as File, pathType, localPathPrefix, githubBaseUrl);
    }

    logger.success("Dependency paths toggled successfully.");
  }

  /// Toggle the paths in the given [pubspecFile].
  Future<void> togglePaths(
    File pubspecFile,
    String pathType,
    String? localPathPrefix,
    String githubBaseUrl,
  ) async {
    // Exclude irrelevant directories
    if (_isExcludedPath(pubspecFile.path)) {
      return;
    }

    logger.info("Processing: ${pubspecFile.path}");

    try {
      final content = await pubspecFile.readAsString();
      final yamlEditor = YamlEditor(content);
      final yamlMap = loadYaml(content) as Map;

      if (yamlMap["dependencies"] == null) {
        logger.warn("No dependencies found in ${pubspecFile.path}");
        return;
      }

      final dependencies = yamlMap["dependencies"] as Map;

      final pathPattern = RegExp(r'^(\.\./)+packages/');

      dependencies.forEach((key, value) {
        if (value is Map && value["path"] != null) {
          final currentPath = value["path"] as String;

          // Match paths with ../packages/ or ../packages/
          if (pathPattern.hasMatch(currentPath)) {
            if (pathType == "local") {
              // If already using a local path, prompt the user to update it
              logger.info("Dependency $key is already using a local path: $currentPath");
              final shouldUpdatePath = logger.confirm(
                prompt: "${'?'.greenBright.bold} Update the current local path for $key?",
              );
              if (shouldUpdatePath) {
                final newLocalPath = logger.prompt(
                  prompt: "${'?'.greenBright.bold} Enter the new local path for $key:",
                );
                if (newLocalPath.isNotEmpty) {
                  yamlEditor.update(["dependencies", key], {"path": newLocalPath});
                  logger.info("Updated $key to new local path: $newLocalPath");
                } else {
                  logger.warn("Invalid path entered. Keeping the existing path.");
                }
              }
            } else if (pathType == "remote") {
              // Toggle to GitHub path with subdirectory support
              final githubPath = "$githubBaseUrl$key";
              yamlEditor.update([
                "dependencies",
                key,
              ], {
                "git": {
                  "url": githubBaseUrl,
                  "path": key,
                },
              });
              logger.info("Toggled $key to remote GitHub path with subdirectory.");
            }
          }
        } else if (value is Map && value["git"] != null && pathType == "local") {
          // Convert GitHub URL back to local path
          final localPath = "$localPathPrefix$key";
          yamlEditor.update(["dependencies", key], {"path": localPath});
          logger.info("Toggled $key to local path.");
        }
      });

      // Save the updated YAML content
      await pubspecFile.writeAsString(yamlEditor.toString());
      logger.success("Updated: ${pubspecFile.path}");
    } catch (e) {
      logger.err("Error processing ${pubspecFile.path}: $e");
    }
  }

  bool _isExcludedPath(String filePath) {
    // List of directories to exclude
    final excludedDirectories = [
      "/.symlinks/",
      "/flutter/ephemeral/",
      "/build/",
      "/.dart_tool/",
    ];

    for (final dir in excludedDirectories) {
      if (filePath.contains(dir)) {
        return true;
      }
    }

    return false;
  }

  String? _getPathType(ArgResults results) {
    final pathType = results["type"] as String?;
    if (pathType != null) {
      if (pathTypes.contains(pathType)) return pathType;
      logger.err("Invalid path type '$pathType'. Use 'local' or 'remote'.");
      return null;
    }

    final selectedType = logger.chooseOne(
      prompt: "${'?'.greenBright.bold} Select a path type",
      options: pathTypes,
    );
    return selectedType;
  }

  String? _getLocalPath(ArgResults results) {
    final localPath = results["local-path"] as String?;
    if (localPath != null && localPath.isNotEmpty) return localPath;

    final enteredPath = logger.prompt(
      prompt: "${'?'.greenBright.bold} Enter the base local path for packages (e.g., ../packages/):",
    );
    if (enteredPath.isEmpty) {
      logger.err("Invalid local path.");
      return null;
    }
    return enteredPath;
  }
}
