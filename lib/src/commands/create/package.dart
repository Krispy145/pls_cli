// import 'package:args/command_runner.dart';
import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:mason/mason.dart';
import 'package:oasis_cli/src/commands/brick_command_base.dart';
import 'package:oasis_cli/src/utils/helpers.dart';

import '../../../bundles/_bundles.dart';

/// {@template packageCommand}
/// Create a new Digital Oasis package.
/// {@endtemplate}
class PackageCommand extends BrickCommandBase {
  /// {@macro packageCommand}
  PackageCommand() {
    argParser
      ..addFlag("wrapper", help: _wrapperPrompt)
      ..addFlag("data", help: _dataPrompt)
      ..addFlag("domain", help: _domainPrompt)
      ..addFlag("presentation", help: _presentationPrompt)
      ..addFlag("open", help: "Open the project in VS Code after creation", defaultsTo: true);
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
    final shouldOpen = argResults?["open"] as bool? ?? additionalArgs?["open"] as bool? ?? true;
    var packageName = argResults?["name"] as String? ?? additionalArgs?["name"] as String?;
    while (packageName == null) {
      logger.info("In while loop");
      final name = logger.prompt(prompt: "What's the name of your package");
      if (name.isNotEmpty) {
        if (isValidDirectoryName(name)) {
          packageName = name;
          break;
        } else {
          logger.info("Invalid name. Must be snake_case 💪");
        }
      }
    }

    argParser.parse(['--name=$packageName']);

    var wrapper = argResults?["wrapper"] as bool? ?? false;
    if (wrapper != true) {
      wrapper = logger.confirm(prompt: _wrapperPrompt);
      if (wrapper) argParser.parse(["--wrapper"]);
    }

    var data = argResults?["data"] as bool? ?? false;
    if (data != true) {
      data = logger.confirm(prompt: _dataPrompt);
      if (data) argParser.parse(["--data"]);
    }

    var domain = argResults?["domain"] as bool? ?? false;
    if (domain != true) {
      domain = logger.confirm(prompt: _domainPrompt);
      if (domain) argParser.parse(["--domain"]);
    }

    var presentation = argResults?["presentation"] as bool? ?? false;
    if (presentation != true) {
      presentation = logger.confirm(prompt: _presentationPrompt);
      if (presentation) argParser.parse(["--presentation"]);
    }

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
    final packageDirectory = Directory(packagePath);
    if (!packageDirectory.existsSync()) {
      logger.err('Project directory not found: $packageName');
      return;
    }

    // Save the current working directory
    final currentDirectory = Directory.current;

    // Change the current working directory to the project directory
    Directory.current = packageDirectory;
    logger.info("Changed directory to $packageName".blue);

    // Now, change into the lib directory
    final libDirectory = Directory('./lib');
    if (!libDirectory.existsSync()) {
      logger.err('lib directory not found in the project.');
      return;
    }

    Directory.current = libDirectory;
    logger.info("Changed directory to lib".blue);

    await runScripts(
      [
        if (data) 'oasis add data_layer --name=$packageName',
        if (domain) 'oasis add domain_layer --name=$packageName',
        if (presentation) 'oasis add presentation_layer --name=$packageName',
        'flutter clean',
        'flutter pub get',
        'dart format .',
      ],
    );

    // Change the current working directory back to the original project directory
    Directory.current = currentDirectory;
    Directory.current = packageDirectory;
    logger.info("Changed directory back to original project directory".blue);

    // Open VS Code with the project directory
    if (shouldOpen) await Process.start('code', ['.', './README.md']);
  }
}
