// import 'package:args/command_runner.dart';
import 'dart:io';

import 'package:mason/mason.dart';
import 'package:oasis_cli/src/commands/brick_command_base.dart';
import 'package:oasis_cli/src/utils/helpers.dart';

import '../../../bundles/_bundles.dart';

/// {@template authCommand}
/// Add a auth layer for the app.
/// {@endtemplate}
class PackageCommand extends BrickCommandBase {
  PackageCommand() {
    argParser
      ..addFlag("wrapper", help: _wrapperPrompt)
      ..addFlag("data", help: _dataPrompt)
      ..addFlag("domain", help: _domainPrompt)
      ..addFlag("presentation", help: _presentationPrompt);
  }

  final _wrapperPrompt = "Do you want a wrapper for this package?";
  final _dataPrompt = "Do you want a data layer for this package?";
  final _domainPrompt = "Do you want a domain layer for this package?";
  final _presentationPrompt = "Do you want a presentation layer for this package?";

  @override
  final MasonBundle bundle = packageBundle;

  @override
  String get description => "Creates a new Digital Oasis package";

  @override
  String get name => "package";

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    logger.info("Creating a new package in: ${Directory.current.path}");
    if (!Directory.current.path.endsWith("packages")) {
      logger.err("You can't create a package inside another package");
      return;
    }
    var packageName = argResults?["name"] as String?;
    while (packageName == null) {
      logger.info("In while loop");
      final name = logger.prompt(prompt: "What's the name of your package");
      if (name.isNotEmpty) {
        if (isValidPackageName(name)) {
          packageName = name;
          break;
        } else {
          logger.info("Invalid name. Must be snake_case 💪");
        }
      }
    }

    argParser.parse(['--name=$packageName']);

    logger.info("Name set to: ${argResults?["name"]} - $packageName");

    var wrapper = argResults?["wrapper"] as bool;
    if (wrapper != true) {
      wrapper = logger.confirm(prompt: _wrapperPrompt);
      if (wrapper) argParser.parse(["--wrapper"]);
    }

    logger.info("Wrapper set to: ${argResults?["wrapper"]}");

    var data = argResults?["data"] as bool;
    if (data != true) {
      data = logger.confirm(prompt: _dataPrompt);
      if (data) argParser.parse(["--data"]);
    }

    logger.info("data set to: ${argResults?["data"]}");

    var domain = argResults?["domain"] as bool;
    if (domain != true) {
      domain = logger.confirm(prompt: _domainPrompt);
      if (domain) argParser.parse(["--domain"]);
    }

    logger.info("domain set to: ${argResults?["domain"]}");

    var presentation = argResults?["presentation"] as bool;
    if (presentation != true) {
      presentation = logger.confirm(prompt: _presentationPrompt);
      if (presentation) argParser.parse(["--presentation"]);
    }

    logger.info("presentation set to: ${argResults?["presentation"]}");

    final packagePath = "./$packageName";

    await runScripts(
      [
        'flutter create --template=package $packageName',
      ],
    );
    await super.run(
      additionalArgs: {
        "name": packageName,
        "path": packagePath,
        "wrapper": wrapper,
      },
    );
    await runScripts(
      [
        if (data) 'oasis add data_layer --name=$packageName --path=$packagePath/lib/data',
        if (domain) 'oasis add domain_layer --name=$packageName --path=$packagePath/lib/domain',
        if (presentation) 'oasis add presentation_layer --name=$packageName --path=$packagePath/lib/presentation',
      ],
    );
  }
}
