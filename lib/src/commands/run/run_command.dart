import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:render_cli/src/commands/base.dart';
import 'package:render_cli/src/utils/find_project_root.dart';
import 'package:yaml/yaml.dart';

/// {@template run_command}
/// Run scripts specified in the pubspec.yaml, similar to npm scripts
/// {@endtemplate}
class RunCommand extends RenderCommand {
  /// {@macro run_command}
  RunCommand() {
    argParser.addFlag(
      "list",
      abbr: "l",
      help: "List all available scripts",
      negatable: false,
    );
  }

  @override
  String get description => "Run scripts specified in the pubspec.yaml";

  @override
  String get name => "run";

  @override
  Future<void> run() async {
    final pubspec = loadPubspec();

    if (!pubspec.containsKey("scripts")) {
      logger.err("Failed to find any scripts in pubspec.");
      return;
    }

    final scripts = pubspec['scripts'] as YamlMap;

    if (argResults != null && (argResults!["list"] as bool? ?? false)) {
      _displayHelp(scripts);
      return;
    }

    final scriptName =
        argResults?.rest.isNotEmpty ?? false ? argResults?.rest[0] : null;
    if (scriptName == null) {
      logger.err("No script specified, please run 'rn run <script name>'");
      _displayHelp(scripts);
      return;
    }
    if (!scripts.containsKey(scriptName)) {
      logger.err("Failed to fid any scripts named $scriptName");
      _displayHelp(scripts);
      return;
    }

    final dynamic commandToRun = scripts[scriptName];
    final script = _Script.fromYaml(scriptName, commandToRun);

    for (final command in script.commands) {
      await processRunner.runString(
        command.command,
        workingDirectory: command.cwd,
      );
    }
    return;
  }

  void _displayHelp(YamlMap scripts) {
    logger
      ..info(
        "${"Available scripts".blue.bold}: \n${scripts.keys.map((key) => "🔹 $key").join("\n")}",
      )
      ..info("To run a script run 'rn run <script name>'");
  }
}

String _replaceEnvVariables(String command) {
  final variableRegex = RegExp(r"\$[a-zA-Z]+");
  final matches = variableRegex.allMatches(command);
  for (final match in matches) {
    final variable = match.group(0);
    if (variable == null) {
      continue;
    }
    final envVariable = variable.substring(1);
    final envValue = Platform.environment[envVariable];
    if (envValue == null) {
      continue;
    }
    command = command.replaceAll(variable, envValue);
  }
  return command;
}

class _Script {
  final String name;

  final List<_StringCommand> commands;

  _Script({required this.name, required this.commands});

  factory _Script.fromYaml(String name, dynamic script) {
    if (script is String) {
      final command = _replaceEnvVariables(script);
      return _Script(name: name, commands: [_StringCommand(command: command)]);
    }
    if (script is YamlList) {
      return _Script(
        name: name,
        commands: script.map(
          (dynamic e) {
            e = e as YamlMap;
            final command = _replaceEnvVariables(e['command'] as String);
            return _StringCommand(
              command: command,
              cwd: e['cwd'] as String?,
            );
          },
        ).toList(),
      );
    }
    throw Exception("Invalid script");
  }
}

class _StringCommand {
  final String command;
  final String? cwd;

  _StringCommand({required this.command, this.cwd});
}
