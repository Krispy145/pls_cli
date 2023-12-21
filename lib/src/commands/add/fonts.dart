import 'dart:io';
import 'package:collection/collection.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:render_cli/bundles/_bundles.dart';

import 'package:render_cli/src/commands/base.dart';
import 'package:render_cli/src/utils/find_project_root.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

/// The Fonts command takes all the fonts in the asset folder and
/// generates the required code in the pubspec
///
/// The file must be in the format <font-family>-<weight>-<style>
class FontsCommand extends RenderCommand {
  @override
  String get description =>
      "Add font assets to pubspec, the file name must be <font-family>-<weight>-<style> eg.ComicNeue-Bold-Italic.ttf";

  @override
  String get name => "fonts";

  @override
  Future<void> run() async {
    final projectRoot = findProjectRoot(Directory.current);

    final pubspecFile = findPubspec(startDir: projectRoot);

    if (!pubspecFile.existsSync()) {
      logger.err("No pubspec file found");
      return;
    }
    final fontsDir = Directory(path.join(projectRoot.path, "assets/fonts"));
    if (!fontsDir.existsSync()) {
      logger.err("No fonts directory found");
      return;
    }

    final pubspecString = pubspecFile.readAsStringSync();
    final pubspec = loadYaml(pubspecString) as YamlMap;

    final yamlEditor = YamlEditor(pubspecString);
    final fonts = _getFontFiles(fontsDir: fontsDir, projectRoot: projectRoot);

    final fontList = fonts.map((f) => f.toJson()).toList();

    if (!pubspec.containsKey("flutter")) {
      //create flutter and fonts
      yamlEditor.update(
        [],
        wrapAsYamlNode({
          "flutter": <String, dynamic>{"fonts": fontList},
        }),
      );
    } else if (!(pubspec["flutter"] as YamlMap).containsKey("fonts")) {
      yamlEditor.update(
        ["flutter"],
        wrapAsYamlNode({
          ...pubspec["flutter"] as YamlMap,
          "fonts": wrapAsYamlNode(fontList),
        }),
      );
    } else {
      for (final font in fontList) {
        yamlEditor.appendToList(["flutter", "fonts"], font);
      }
    }

    await pubspecFile.writeAsString(yamlEditor.toString());
    await runScripts(
        ['flutter pub run build_runner build --delete-conflicting-outputs'],);
    // await _createFontFamilyDartFile(fonts, projectRoot);

    return;
  }

  List<Font> _getFontFiles({
    required Directory fontsDir,
    required Directory projectRoot,
  }) {
    final fonts = <Font>[];
    for (final entity in fontsDir.listSync()) {
      if (entity is Directory) {
        fonts.addAll(
          _getFontFiles(
            fontsDir: entity,
            projectRoot: projectRoot,
          ),
        );
      }
      if (entity is File &&
          path.basenameWithoutExtension(entity.path) != ".DS_Store") {
        final fileName = path.basenameWithoutExtension(entity.path).split("-");

        final familyName = fileName[0];

        final variant = FontVariant(
          asset: path.relative(entity.path, from: projectRoot.path),
          weight: fileName.length >= 2 ? _stringToWeight(fileName[1]) : null,
          style: fileName.length >= 3 ? fileName[2].toLowerCase() : null,
        );

        final font =
            fonts.firstWhereOrNull((element) => element.family == familyName);

        if (font == null) {
          fonts.add(Font(family: familyName, variants: [variant]));
        } else {
          font.variants.add(variant);
        }
      }
    }
    return fonts;
  }

  Future<void> _createFontFamilyDartFile(
    List<Font> fonts,
    Directory projectRoot,
  ) async {
    final bundle = fontFamilyBundle;

    final generateProgress = logger.progress('Generating dart file');

    final generator = await MasonGenerator.fromBundle(bundle);
    final target = Directory(path.join(projectRoot.path, "lib", "theme"));
    if (!target.existsSync()) {
      target.createSync(recursive: true);
    }
    final targetGen = DirectoryGeneratorTarget(target);

    await generator.generate(
      targetGen,
      vars: <String, dynamic>{
        "fonts": fonts.map((f) => f.family).toList(),
      },
      logger: Logger(),
    );
    generateProgress.finish(showTiming: true);
  }

  int _stringToWeight(String input) {
    switch (input.toLowerCase()) {
      case "thin":
        return 200;
      case "light":
        return 300;
      case "regular":
        return 400;
      case "medium":
        return 500;
      case "semibold":
        return 600;
      case "bold":
        return 700;
      case "black":
        return 900;
      default:
        return 400;
    }
  }
}

///
class Font {
  ///
  final String family;

  ///
  List<FontVariant> variants;

  ///
  Font({
    required this.family,
    required this.variants,
  });

  ///
  Map<String, dynamic> toJson() => <String, dynamic>{
        "family": family,
        "fonts": variants.map((e) => e.toJson()).toList(),
      };
}

///
class FontVariant {
  ///
  final int? weight;

  ///
  final String? style;

  ///
  final String asset;

  ///
  const FontVariant({
    required this.asset,
    required this.weight,
    required this.style,
  });

  ///
  Map<String, dynamic> toJson() => <String, dynamic>{
        "asset": asset,
        if (weight != null) "weight": weight,
        if (style != null) "style": style,
      };
}
