// import 'package:args/command_runner.dart';
import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:mason/mason.dart';
import 'package:oasis_cli/src/commands/brick_command_base.dart';
import 'package:oasis_cli/src/commands/create/app.dart';
import 'package:oasis_cli/src/utils/helpers.dart';

import '../../../bundles/_bundles.dart';
import 'package.dart';

/// {@template managedAppCommand}
/// Create a new Digital Oasis managed app.
/// Creates a Dashboard app, user app, and a package to communicate between the two.
/// {@endtemplate}
class ManagedAppCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = packageBundle;

  @override
  String get description => "Creates a new Digital Oasis managed app";

  @override
  String get name => "managed_app";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    var packageName = argResults?["name"] as String?;
    while (packageName == null) {
      logger.info("In while loop");
      final name = logger.prompt(prompt: "What's the name of your managed app");
      if (name.isNotEmpty) {
        if (isValidDirectoryName(name)) {
          packageName = name;
          break;
        } else {
          logger.info("Invalid name. Must be snake_case 💪");
        }
      }
    }
    final managedAppDirectory = Directory("${Directory.current.path}/$packageName");
    if (!managedAppDirectory.existsSync()) {
      logger.info('Creating managed app directory');
      managedAppDirectory.createSync();
    }
    Directory.current = managedAppDirectory;
    argParser.parse(['--name=$packageName']);
    final userAppCommand = CreateAppCommand(appName: "${packageName}_app", openVSCode: false);
    final dashboardAppCommand = CreateAppCommand(appName: "${packageName}_dashboard", openVSCode: false);
    final packageCommand = PackageCommand();
    logger.info("Creating managed app 🚀".yellow);
    await userAppCommand.run();
    logger
      ..info("User app created ✅\n\n".green)
      ..info("Creating dashboard app 🚀".yellow);
    Directory.current = managedAppDirectory;
    await dashboardAppCommand.run();
    logger
      ..info("Dashboard app created ✅\n\n".green)
      ..info("Creating package 🚀".yellow);
    Directory.current = managedAppDirectory;
    await packageCommand.run(additionalArgs: {"name": packageName, "open": false});
    logger.info("Package created ✅\n\n".green);
    Directory.current = managedAppDirectory;

    await Process.start('code', [
      './$packageName',
      './${packageName}_app',
      './${packageName}_dashboard',
    ]);
  }
}
