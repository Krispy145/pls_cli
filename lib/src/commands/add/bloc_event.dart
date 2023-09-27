import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';
import 'package:render_cli/src/commands/base.dart';

/// Adds an event to an existing bloc
class BlocEventCommand extends RenderCommand {
  /// Adds an event to an existing bloc
  BlocEventCommand() {
    argParser
      ..addOption("path", abbr: "p", help: "Path to the bloc file")
      ..addOption("name", help: "The name of the event");
  }

  @override
  String get description => "Add an event to a bloc";

  @override
  String get name => "event";

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) {
      logger.err("No arg results found");
      return;
    }
    final inputFile = File(results['path'] as String);

    if (!inputFile.existsSync()) {
      logger.err("No file found at path '${results['path']}'");
      return;
    }
    final dir = inputFile.parent;
    final allFiles = dir.listSync();
    File? blocFile;
    File? eventFile;

    // find the event and bloc files
    for (final f in allFiles) {
      final isGenerated = p
          .basename(f.path)
          .contains(RegExp(r"\b(freezed.dart)\b|\b(g.dart)\b"));
      if (p.basenameWithoutExtension(f.path).contains("bloc") && !isGenerated) {
        blocFile = f as File;
      } else if (p.basenameWithoutExtension(f.path).contains("event")) {
        eventFile = f as File;
      }
    }
    if (blocFile == null || eventFile == null) {
      logger.err("Bloc file or event file not found");

      return;
    }
    // get bloc name
    final blocName =
        p.basenameWithoutExtension(blocFile.path).replaceAll("_bloc", "");

    // parse the event name
    final eventName = results['name'] as String? ??
        logger.prompt(prompt: "What is the name of the event?");

    // add event to event file
    eventFile.writeAsStringSync(
      """
    class ${blocName.pascalCase}${eventName.pascalCase} extends ${blocName.pascalCase}Event {}
""",
      mode: FileMode.append,
    );
    Process.runSync("dart", ["format", eventFile.absolute.path]);

    // register the event in the bloc constructor
    final parsedFile = parseFile(
      path: blocFile.absolute.path,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    for (final declaration in parsedFile.unit.declarations) {
      if (declaration is ClassDeclaration) {
        // final constructor = declaration.getConstructor(null);
        final constructor =
            declaration.members.whereType<ConstructorDeclaration>().firstOrNull;

        if (constructor == null) {
          logger.err('No constructor found');
          return;
        }
        final constructorEnd = constructor.end;
        final closingOffset = declaration.rightBracket.charOffset;
        // Add the new event to the constructor and add a function to the body
        blocFile.writeAsStringSync(
          """${parsedFile.content.substring(0, constructorEnd - 1)}
            on<${blocName.pascalCase}${eventName.pascalCase}>(_on${eventName.pascalCase});

          ${parsedFile.content.substring(constructorEnd - 1, closingOffset)}

          FutureOr<void>_on${eventName.pascalCase}(
            ${blocName.pascalCase}${eventName.pascalCase} event,
            Emitter<${blocName.pascalCase}State> emit,
          ){}

          ${parsedFile.content.substring(closingOffset)}

""",
        );
        Process.runSync("dart", ["format", blocFile.absolute.path]);
      }
    }

    return;
  }
}
