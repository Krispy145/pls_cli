import 'package:mason/mason.dart';
import 'package:render_cli/src/commands/base.dart';
import 'package:render_cli/src/utils/structures.dart';

/// {@template structureCommand}
/// Add a structure to the app.
/// {@endtemplate}
class StructuresCommand extends RenderCommand {
  /// {@macro structureCommand}
  StructuresCommand() {
    argParser.addOption(
      'type',
      defaultsTo: 'Default',
      help: 'The type of the structure.',
    );
  }

  @override
  String get description => "Creates a new structure for the app";

  @override
  String get name => "structure";

  @override
  Future<void> run() async {
    final structureArg = argResults?['type'] as String? ??
        logger.chooseOne(
          prompt: 'Select the app structure:',
          options: Structure.values.map((e) => e.name).toList(),
        );
    final structureType = Structure.values.firstWhere((e) => e.name == structureArg.pascalCase, orElse: () => Structure.Default);

    switch (structureType) {
      case Structure.Default:
        await runInLibDirectory(
          () => runScripts(["rn add default_structure"]),
          extensionPath: 'navigation',
        );
        break;
      case Structure.DefaultMap:
        await runInLibDirectory(
          () => runScripts(["rn add default_map_structure"]),
          extensionPath: 'navigation',
        );
        break;
      case Structure.Map:
        await runInLibDirectory(
          () => runScripts(["rn add map_structure"]),
          extensionPath: 'navigation',
        );
        break;
      case Structure.Dashboard:
        await runInLibDirectory(
          () => runScripts(["rn add dashboard_structure"]),
          extensionPath: 'navigation',
        );
        break;
    }

    return runScripts([
      'dart format .',
      'dart fix --apply',
    ]);
  }
}
