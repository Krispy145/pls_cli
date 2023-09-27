import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:render_cli/bundles/_bundles.dart';
import 'package:render_cli/src/commands/base.dart';
import 'package:render_cli/src/utils/find_project_root.dart';

/// Generate a enum style static class for all assets
/// Looks for the assets folder in the root of the project
/// and generates a class with all the assets as static const
class AssetsCommand extends RenderCommand {
  @override
  String get description => "Generate a enum style static class for all assets";

  @override
  String get name => "assets";

  @override
  Future<void> run() async {
    final bundle = assetsBundle;
    final projectRoot = findProjectRoot(Directory.current);

    final assetsDir = Directory(path.join(projectRoot.path, "assets"));
    if (!assetsDir.existsSync()) {
      logger.err("No assets directory found");
      return;
    }

    final assets = _findAssets(dir: assetsDir, root: projectRoot);

    final generateProgress = logger.progress('Generating dart file');

    final generator = await MasonGenerator.fromBundle(bundle);
    final target =
        Directory(path.join(projectRoot.path, "lib", "core", "models"));
    if (!target.existsSync()) {
      target.createSync(recursive: true);
    }
    final targetGen = DirectoryGeneratorTarget(target);

    await generator.generate(
      targetGen,
      fileConflictResolution: FileConflictResolution.overwrite,
      vars: <String, dynamic>{
        "assets": assets.map((e) => e.toJson()).toList(),
      },
      logger: Logger(),
    );
    generateProgress.finish(showTiming: true);
  }
}

List<_Asset> _findAssets({
  required Directory dir,
  required Directory root,
  List<_Asset>? current = const [],
}) {
  final assets = <_Asset>[];
  final directories = <Directory>[];
  // in order to handle images at multiple sizes we need to add the file assets first
  for (final entity in dir.listSync()) {
    if (entity is Directory) {
      directories.add(entity);
    } else if (entity is File) {
      final name = path.basename(entity.path);

      if (name.startsWith(".")) continue;

      final assetPath = path.relative(entity.path, from: root.path);
      final asset = _Asset(name: name, path: Uri.decodeFull(assetPath));
      if (!assets.any((element) => element.name == asset.name) &&
          !current!.any((element) => element.name == asset.name)) {
        assets.add(asset);
      }
    }
  }

  for (final entity in directories) {
    if (path.basename(entity.path) == "fonts") continue;
    final newAssets = _findAssets(dir: entity, root: root, current: assets);
    assets.addAll(newAssets);
  }
  return assets;
}

class _Asset {
  final String name;
  final String path;

  _Asset({required this.name, required this.path});

  Map<String, String> toJson() => {"name": name, "path": path};
}
