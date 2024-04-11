// import 'package:args/command_runner.dart';
import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:mason/mason.dart';
import 'package:oasis_cli/src/commands/brick_command_base.dart';
import 'package:oasis_cli/src/commands/create/app.dart';
import 'package:oasis_cli/src/utils/helpers.dart';

import '../../../bundles/_bundles.dart';
import 'package.dart';

/// {@template ecosystemCommand}
/// Create a new Digital Oasis Ecosystem.
/// Creates a Dashboard app, user app, and a package to communicate between the two.
/// {@endtemplate}
class EcosystemCommand extends BrickCommandBase {
  @override
  final MasonBundle bundle = packageBundle;

  @override
  String get description => "Creates a new Digital Oasis Ecosystem";

  @override
  String get name => "ecosystem";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    logger.info("Creating Ecosystem 🚀".yellow);
    var packageName = argResults?["name"] as String?;
    while (packageName == null) {
      final name = logger.prompt(prompt: "What's the name of your Ecosystem");
      if (name.isNotEmpty) {
        if (isValidDirectoryName(name)) {
          packageName = name;
          break;
        } else {
          logger.info("Invalid name. Must be snake_case 💪");
        }
      }
    }
    final ecosystemDirectory = Directory("${Directory.current.path}/$packageName");
    if (!ecosystemDirectory.existsSync()) {
      logger.info('Creating Ecosystem directory');
      ecosystemDirectory.createSync();
    }
    Directory.current = ecosystemDirectory;
    argParser.parse(['--name=$packageName']);
    final userAppCommand = CreateAppCommand(appName: "${packageName}_app", openVSCode: false);
    final dashboardAppCommand = CreateAppCommand(appName: "${packageName}_dashboard", openVSCode: false);
    final packageCommand = PackageCommand();
    logger.info("Creating user app 🚀".yellow);
    await userAppCommand.run();
    logger
      ..info("User app created ✅\n\n".green)
      ..info("Creating dashboard app 🚀".yellow);
    Directory.current = ecosystemDirectory;
    await dashboardAppCommand.run();
    logger
      ..info("Dashboard app created ✅\n\n".green)
      ..info("Creating package 🚀".yellow);
    Directory.current = ecosystemDirectory;
    await packageCommand.run(additionalArgs: {"name": packageName, "open": false});
    logger.info("Package created ✅\n\n".green);
    Directory.current = ecosystemDirectory;

    await Process.start('code', [
      './$packageName',
      './${packageName}_app',
      './${packageName}_dashboard',
    ]);
  }
}
