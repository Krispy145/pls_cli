import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:render_cli/src/commands/base.dart';

/// Update the cli or extension
class UpdateCommand extends RenderCommand {
  /// Update the cli or extension
  UpdateCommand() {
    argParser.addFlag(
      "vscode",
      help:
          "Update the vscode extension, requires vsce to be installed globally.",
    );
  }
  @override
  String get description => "Update the cli or extension";

  @override
  String get name => "update";

  @override
  FutureOr<void> run() async {
    final results = argResults;
    if (results == null) {
      throw Exception("No args provided");
    }
    final updateVscode = results["vscode"] as bool;
    if (updateVscode) {
      final tempDir = Directory.systemTemp.createTempSync("flutter_cli");

      final clonedProgress = logger.spinner(
        icon: "👌",
        rightPrompt: (done) => done ? "Project Cloned" : "Cloning project",
      );

      try {
        await processRunner.runLog(
          "git",
          [
            "clone",
            "--depth",
            "1",
            githubPath,
            tempDir.path,
          ],
        );
        clonedProgress.done();
      } catch (_) {
        clonedProgress.done();
        logger.err("Error cloning project");
        return;
      }

      Directory.current =
          Directory(path.join(tempDir.path, "extensions", "vscode"));

      final buildingProgress = logger.spinner(
        icon: "🏗️",
        rightPrompt: (done) => done ? "Extension built" : "Building extension",
      );
      try {
        await processRunner.runLog("npm", ["install"]);
        await processRunner.runLog("npm", ["run", "build"]);
        buildingProgress.done();
      } catch (_) {
        buildingProgress.done();

        logger.err("Error building project");
        return;
      }

      final installingProgress = logger.spinner(
        icon: "✅",
        rightPrompt: (done) =>
            done ? "Extension installed!" : "Installing extension",
      );
      try {
        await processRunner.runLog(
          "code",
          ["--install-extension", "digital-oasis.vsix"],
        );
        installingProgress.done();
      } catch (_) {
        installingProgress.done();

        logger.err("Error installing project");
        return;
      }
    } else {
      await processRunner.runLog(
        "flutter",
        [
          "pub",
          "global",
          "activate",
          "-sgit",
          githubPath,
        ],
      );
    }

    return;
  }
}
