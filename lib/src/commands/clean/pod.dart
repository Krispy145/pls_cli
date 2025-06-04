import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:path/path.dart' as path;
import 'package:pls_cli/src/commands/base.dart';
import 'package:pls_cli/src/utils/helpers.dart';

/// {@template podclean}
/// Clean the pod files. Deletes pods, podfile.lock and reinstalls
/// {@endtemplate}
class PodCleanCommand extends PLSCommand {
  /// {@macro podclean}
  PodCleanCommand() {
    argParser.addFlag("repo-update", abbr: "u");
  }

  @override
  String get description => "Cleans the pod files and updates pod.";

  @override
  String get name => "pod";

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) {
      logger.err("Error loading args");
      return;
    }

    final root = findProjectRoot(Directory.current);

    final podsDir = Directory(path.join(root.path, "ios", "Pods"));

    if (!podsDir.existsSync()) {
      logger.err("No pods folder found");
      return;
    }

    final podfileLock = File(path.join(root.path, "ios", "Podfile.lock"));
    if (!podfileLock.existsSync()) {
      logger.err("No Podfile.lock found");
      return;
    }

    Directory.current = podsDir.parent;
    logger.info("Changed working directory to: ${podsDir.parent.path}".blue);

    var spinner = logger.spinner(
      rightPrompt: (complete) => complete ? "Finished deleting Pods folder" : "Deleting Pods folder.",
    );
    podsDir.deleteSync(recursive: true);
    spinner.done();

    spinner = logger.spinner(
      rightPrompt: (complete) => complete ? "Deleted Podfile.lock" : "Deleting Podfile.lock.",
    );
    podfileLock.deleteSync();
    spinner.done();
    final updatePod = results['repo-update'] as bool;

    spinner = logger.spinner(
      icon: "✅",
      rightPrompt: (complete) => complete ? " Done" : "Installing pods",
    );
    if (updatePod) {
      await processRunner.runLog("pod", ["install", "--repo-update"]);
    } else {
      await processRunner.runLog("pod", ["install"]);
    }
    spinner.done();
  }
}
