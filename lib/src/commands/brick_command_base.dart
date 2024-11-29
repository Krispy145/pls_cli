import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:args/args.dart';
import 'package:lets_yak_cli/src/commands/base.dart';
import 'package:lets_yak_cli/src/logger.dart';
import 'package:mason/mason.dart' as mason;
import 'package:path/path.dart' as p;

/// {@template brickCommandBase}
///
/// The base of any command which generates files from bricks
///
/// {@endtemplate}
abstract class BrickCommandBase extends LYCommand {
  /// BrickCommandBase constructor
  BrickCommandBase() {
    argParser.addDefaultOptions();
  }

  /// The bundled template
  mason.MasonBundle get bundle;
  set bundle(mason.MasonBundle b) => bundle = b;

  /// List of all pre hooks to be called in order
  List<PreHook> preHooks = [];

  @override
  Future<void> run({Map<String, dynamic>? additionalArgs}) async {
    final results = argResults;
    if (results == null && additionalArgs == null) {
      if (stderr.hasTerminal) logger.err("No argument results found");
      return;
    }

    final givenPath = results?['path'] as String? ?? additionalArgs?['path'] as String?;

    final cwd = Directory.current;

    String outputPath;

    if (givenPath != null) {
      outputPath = p.canonicalize(p.join(cwd.path, givenPath));
    } else {
      outputPath = cwd.path;
    }

    final outputDir = Directory(outputPath);
    if (!outputDir.existsSync()) {
      await outputDir.create(recursive: true);
    }

    final target = mason.DirectoryGeneratorTarget(outputDir);
    var vars = parseVars(
      results,
      additionalArgs: additionalArgs,
    );

    // update vars with hooks
    for (final hook in preHooks) {
      vars = await hook(vars, results, outputPath);
    }

    await generator(target, vars);
  }

  /// mason generator
  Future<void> generator(
    mason.DirectoryGeneratorTarget target,
    Map<String, dynamic>? vars,
  ) async {
    final generator = await mason.MasonGenerator.fromBundle(bundle);
    final progress = logger.spinner(
      rightPrompt: (done) => done ? "" : 'Making ${generator.id}',
    );
    try {
      if (vars != null) {
        final files = await generator.generate(
          target,
          vars: vars,
          fileConflictResolution: mason.FileConflictResolution.overwrite,
          logger: mason.Logger(),
        );

        logger.logFilesGenerated(files.length);

        final filesChanged = files.where((file) => file.hasChanged);
        logger.logFilesChanged(filesChanged.length);

        if (filesChanged.isNotEmpty) return;
      }
      return;
    } catch (_) {
      rethrow;
    } finally {
      progress.done();
    }
  }

  /// Parse the command variables and prompt if they don't exist.
  Map<String, dynamic> parseVars(ArgResults? results, {Map<String, dynamic>? additionalArgs}) {
    final vars = <String, dynamic>{};
    if (additionalArgs != null) vars.addAll(additionalArgs);
    for (final entry in bundle.vars.entries) {
      final variable = entry.key;
      final properties = entry.value;

      if (vars.containsKey(variable)) continue;
      final dynamic arg = results?[variable];
      if ((arg is! List && arg != null) || (arg is List && arg.isNotEmpty)) {
        // The argument has been passed through the command line
        vars.addAll(<String, dynamic>{variable: _maybeDecode(arg)});
      } else {
        final prompt = '''${'?'.greenBright.bold} ${properties.prompt ?? variable}''';
        late final dynamic response;
        //ignore: missing_enum_constant_in_switch
        switch (properties.type) {
          case mason.BrickVariableType.string:
            response = _maybeDecode(
              logger.prompt(
                prompt: prompt,
                defaultValue: properties.defaultValue as String?,
              ),
            );
            break;
          case mason.BrickVariableType.number:
            response = logger.prompt(
              prompt: prompt,
              defaultValue: properties.defaultValue as String?,
            );
            if (num.tryParse(response as String) == null) {
              throw FormatException(
                'Invalid $variable.\n"$response" is not a number.',
              );
            }
            break;
          case mason.BrickVariableType.boolean:
            response = logger.confirm(
              prompt: prompt,
              defaultValue: properties.defaultValue as bool? ?? false,
            );
        }
        vars.addAll(<String, dynamic>{variable: response});
      }
    }
    return vars;
  }

  dynamic _maybeDecode(dynamic value) {
    try {
      if (value is String) return json.decode(value);
      return value;
    } catch (_) {
      return value;
    }
  }
}

/// Default options extension
extension DefaultOptions on ArgParser {
  /// Adds the default arguments to all brick commands
  void addDefaultOptions() {
    this
      ..addOption(
        "path",
        abbr: "p",
        help: 'Directory where to output the generated code.',
      )
      ..addOption(
        "name",
        abbr: "n",
        help: "The name of the generated item.",
      )
      ..addFlag(
        "runner",
        help: "Run the build runner after the generation",
      );
  }
}

extension on Logger {
  void logFilesChanged(int fileCount) {
    if (fileCount == 0) return info('${'✅'} 0 files changed');
    return fileCount == 1 ? info("🎉 $fileCount file changed") : info("🎉 $fileCount files changed");
  }

  void logFilesGenerated(int fileCount) {
    if (fileCount == 1) {
      info(
        '🎉 '
        'Generated $fileCount file:',
      );
    } else {
      info(
        '🎉 '
        'Generated $fileCount file(s):',
      );
    }
  }
}

extension on mason.GeneratedFile {
  bool get hasChanged {
    switch (status) {
      case mason.GeneratedFileStatus.created:
      case mason.GeneratedFileStatus.overwritten:
      case mason.GeneratedFileStatus.appended:
        return true;
      case mason.GeneratedFileStatus.skipped:
      case mason.GeneratedFileStatus.identical:
        return false;
    }
  }
}

/// A hook that will be called before the generation.
///
/// Must return the new or unchanged variables.
typedef PreHook = FutureOr<Map<String, dynamic>> Function(
  Map<String, dynamic> vars,
  ArgResults? argResults,
  String? outputDir,
);
