import 'dart:io';

import 'package:mason/mason.dart';
import 'package:pls_cli/src/commands/base.dart';
import 'package:pls_cli/src/commands/brick_command_base.dart';
import 'package:pls_cli/src/utils/structures.dart';

import '../../../bundles/_bundles.dart';

/// {@template structureCommand}
/// Add a structure to the app.
/// {@endtemplate}
class StructuresCommand extends PLSCommand {
  /// {@macro structureCommand}
  StructuresCommand() {
    argParser
      ..addDefaultOptions()
      ..addOption(
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
    final buildRunner = argResults?['runner'] as bool? ?? false;
    final structureArg = argResults?['type'] as String? ??
        logger.chooseOne(
          prompt: 'Select the app structure:',
          options: Structure.values.map((e) => e.name).toList(),
        );
    final structureType = Structure.values.firstWhere((e) => e.name == structureArg.pascalCase, orElse: () => Structure.Default);

    await runInLibDirectory(() => _setupStructureFiles(structureType), extensionPath: 'navigation');

    return runScripts([
      if (buildRunner) 'flutter pub run build_runner build --delete-conflicting-outputs',
      'dart fix --apply',
    ]);
  }

  Future<void> _setupStructureFiles(
    Structure selectedStructure,
  ) async {
    // Create a progress indicator for adding the structure files
    final structureProgress = logger.progress('Add Structure Files');
    try {
      MasonBundle structureBundle() {
        switch (selectedStructure) {
          case Structure.Default:
            return defaultStructureBundle;
          case Structure.Map:
            return mapStructureBundle;
          case Structure.DefaultMap:
            return defaultMapStructureBundle;
          case Structure.Dashboard:
            return dashboardStructureBundle;
          case Structure.DefaultDashboard:
            return defaultDashboardStructureBundle;
        }
      }

      final generator = await MasonGenerator.fromBundle(structureBundle());

      final target = DirectoryGeneratorTarget(Directory.current);

      final files = await generator.generate(
        target,
        fileConflictResolution: FileConflictResolution.overwrite,
        logger: Logger(),
      );

      structureProgress.finish(
        message: ' ${selectedStructure.name} Structure Files Added: ${files.length} file(s)',
        showTiming: true,
      );
    } catch (e) {
      structureProgress.finish(
        message: "Failed to add structure files: $e",
        showTiming: true,
      );
      throw Exception('Failed to add structure files');
    }
  }
}
