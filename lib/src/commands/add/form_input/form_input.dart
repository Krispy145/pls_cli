import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:render_cli/src/commands/add/form_input/templates.dart';
import 'package:render_cli/src/commands/base.dart';

import '../../../utils/function_visitor.dart';
import '../../../utils/process_log.dart';
import 'form_names.dart';

/// Adds an event to an existing bloc
class FormInputCommand extends RenderCommand {
  /// The name of the parts of the form
  late FormNames _formNames;

  /// Whether the selected form is a bloc or cubit
  bool _isBloc = true;

  /// Adds an event to an existing bloc
  FormInputCommand() {
    argParser
      ..addOption(
        "path",
        abbr: "p",
        help: "Path to the bloc file",
        mandatory: true,
      )
      ..addOption("name", help: "The name of the input");
  }

  @override
  String get description => "Add an input to a form";

  @override
  String get name => "input";

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
    File? stateFile;

    // find the event and bloc files
    for (final f in allFiles) {
      final isGenerated = path
          .basename(f.path)
          .contains(RegExp(r"\b(freezed.dart)\b|\b(g.dart)\b"));
      if (path.basenameWithoutExtension(f.path).contains("bloc") &&
          !isGenerated) {
        blocFile = f as File;
      } else if (path.basenameWithoutExtension(f.path).contains("event")) {
        eventFile = f as File;
      } else if (path.basenameWithoutExtension(f.path).contains("state")) {
        stateFile = f as File;
      } else if (path.basenameWithoutExtension(f.path).contains("cubit") &&
          !isGenerated) {
        blocFile = f as File;
        _isBloc = false;
      }
    }
    if (blocFile == null ||
        (eventFile == null && _isBloc == true) ||
        stateFile == null) {
      logger.err("Bloc file, event file or state file not found");
      return;
    }

    // parse the event name
    final inputName = results['name'] as String? ??
        logger.prompt(prompt: "What is the name of the input?");

    _formNames = FormNames(
      inputName: inputName,
      blocName: path.basenameWithoutExtension(blocFile.path),
    );

    if (_isBloc) {
      // add event to event file
      _addBlocEvent(eventFile!);
    }
    _registerBlocEvent(blocFile: blocFile);
    await _addInputComponent(blocFile: blocFile);
    await _addStateField(stateFile: stateFile);

    return;
  }

  void _addBlocEvent(File eventFile) {
    final event = buildBlocEvent(names: _formNames);
    eventFile.writeAsStringSync(
      event,
      mode: FileMode.append,
    );
    Process.runSync("dart", ["format", eventFile.absolute.path]);
  }

  void _registerBlocEvent({
    required File blocFile,
  }) {
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
          logger.err("No constructor found");
          throw Exception("No constructor found");
        }
        final constructorEnd = constructor.end;
        final closingOffset = declaration.rightBracket.charOffset;

        final event = buildBlocEventHandler(
          isBloc: _isBloc,
          names: _formNames,
          closingOffset: closingOffset,
          constructorEnd: constructorEnd,
          parsedFile: parsedFile,
        );
        // Add the new event to the constructor and add a function to the body
        blocFile.writeAsStringSync(event);
        Process.runSync("dart", ["format", blocFile.absolute.path]);
      }
    }
  }

  Future<void> _addInputComponent({
    required File blocFile,
  }) async {
    // find the form component file
    final componentPath = path.join(
      blocFile.parent.path,
      "../",
      "../",
      "components",
      "${_formNames.componentFileName.snakeCase}.dart",
    );
    final formComponentFile = File(componentPath);
    final component = buildComponent(names: _formNames, isBloc: _isBloc);

    // If the component file can't be found for some reason copy the component instead
    if (!formComponentFile.existsSync()) {
      logger.err(
        "No form component found, copying to component to clipboard instead",
      );
      await runShellCommand("echo '$component' | pbcopy");
      return;
    }

    // add to the found component file.
    formComponentFile.writeAsStringSync(component, mode: FileMode.append);
    Process.runSync("dart", ["format", formComponentFile.absolute.path]);
  }

  Future<void> _addStateField({
    required File stateFile,
  }) async {
    // parse ast
    final parsedFile = parseFile(
      path: stateFile.absolute.path,
      featureSet: FeatureSet.latestLanguageVersion(),
    );
    Iterable<ConstructorDeclaration> constructors = [];
    // find the factory
    for (final declaration in parsedFile.unit.declarations) {
      if (declaration is ClassDeclaration) {
        constructors = declaration.members.whereType<ConstructorDeclaration>();
        break;
      }
    }
    ConstructorDeclaration? freezedConstructor;
    ConstructorDeclaration? initialState;
    for (final constructor in constructors) {
      if (constructor.name == null &&
          (constructor.factoryKeyword?.isKeywordOrIdentifier ?? false)) {
        freezedConstructor = constructor;
      } else if (constructor.name.toString() == "initial") {
        initialState = constructor;
      }
    }
    if (freezedConstructor == null || initialState == null) {
      throw Exception("constructors not found");
    }
    // add input to constructor
    final firstParameter = freezedConstructor.parameters.parameters.first;
    final paramStart = (freezedConstructor.parameters.leftDelimiter?.offset ??
            freezedConstructor.parameters.leftParenthesis.offset) +
        1;

    String newInput;
    if (firstParameter.isNamed) {
      newInput =
          "required FormInputModel<String> ${_formNames.inputName.camelCase}";
    } else {
      // An input should always be named, but just in case
      newInput = "FormInputModel<String> ${_formNames.inputName.camelCase}";
    }

    // add input to initial state

    ExpressionFunctionBody? initialStateBody;

    initialState.body.accept(
      FunctionVisitor(
        onExpressionFunctionBodyFound: (node) => initialStateBody = node,
      ),
    );
    if (initialStateBody == null ||
        initialStateBody!.expression is! MethodInvocation) {
      logger.err("No initial state function body found");
      throw Exception("No initial state function body found");
    }
    final initialStateClass = initialStateBody!.expression as MethodInvocation;
    final currentArgsStart =
        initialStateClass.argumentList.leftParenthesis.offset + 1;
    final newInitialArgument =
        "${_formNames.inputName.camelCase}: FormInputModel(validator: (value) => value.required()),";

    stateFile.writeAsStringSync("""
${parsedFile.content.substring(0, paramStart)}
  $newInput,
  ${parsedFile.content.substring(paramStart, currentArgsStart)}
  $newInitialArgument
  ${parsedFile.content.substring(currentArgsStart)}
    """);

    Process.runSync("dart", ["format", stateFile.absolute.path]);
  }
}
