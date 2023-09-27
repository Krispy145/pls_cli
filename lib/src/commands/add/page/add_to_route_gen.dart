import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

import '../../../utils/find_project_root.dart';
import '../../../utils/function_visitor.dart';

/// Find the route_generator.dart file and add the page to the router.
///
/// Must pass [pageName] which is the name of the route/page.
/// [hasArguments] is whether the route will have an arguments object. This will
/// have the name <pageName>PageArguments.
///
/// [outputDir] is the directory the new page is being generated. This is the
/// starting point when looking for the pubspec.yaml.
///
/// Pass [pathToRouteGen] if the path to the route_generator.dart file is already
/// known.
///
/// Pass [selectedGeneratorIndex] if the index of the selected generator is already
/// known.
void addToRouteGen({
  required String pageName,
  required bool hasArguments,
  required String outputDir,
  String? pathToRouteGen,
  String? selectedGeneratorIndex,
}) {
  final logger = Logger();
  // find the route_generator
  final routeGenPath =
      pathToRouteGen ?? findGeneratorPath(outputDir: outputDir, logger: logger);

  final file = File(routeGenPath);

  final res = parseFile(
    path: routeGenPath,
    featureSet: FeatureSet.latestLanguageVersion(),
    throwIfDiagnostics: false,
  );

  final routers = listRouters(parsedFile: res);

  // stdout
  //   ..writeln("Route generators found: ")
  //   ..writeln(routers.map((e) => e.name).toString())
  //   ..writeln(
  //       "Which route generator would you like to add the page to? ${List.generate(routers.length, (index) => index)}");
  // final selection = stdin.readLineSync();
  String response;
  if (selectedGeneratorIndex == null) {
    if (routers.isEmpty) {
      stderr.writeln("No routers found");
      return;
    }
    stdout.writeAll(routers.mapIndexed<String>((i, r) => "[$i] ${r.name}\n"));
    response = logger.prompt(
      "pick a route generator: [0]",
      defaultValue: 0,
    );
  } else {
    response = selectedGeneratorIndex;
  }

  final resNum = int.tryParse(response);
  if (resNum == null) {
    throw FormatException(
      'Invalid Index.\n"$response" is not an int.',
    );
  }
  if (resNum > routers.length - 1 || resNum < 0) {
    throw FormatException(
      'Invalid Index.\n"$response" is not in range.',
    );
  }
  final routeGenerator = routers[resNum];

  final body = routeGenerator.functionExpression.body;
  if (body is BlockFunctionBody) {
    SwitchCase? switchCase;
    body.block.visitChildren(
      FunctionVisitor(onCaseFound: (s) => switchCase = s),
    );
    if (switchCase == null) {
      stderr.writeln("No switch case found");
      return;
    }
    final startOffset = switchCase!.offset;

    file.writeAsStringSync(
      """${res.content.substring(0, startOffset - 1)}        
      case ${pageName.pascalCase}Page.routeName:
        return MaterialPageRoute<${pageName.pascalCase}Page>(
          builder: (_) => ${hasArguments ? "" : "const"} ${pageName.pascalCase}Page(${hasArguments ? "args: settings.arguments as ${pageName.pascalCase}PageArguments," : ""}),
      );
      
      ${res.content.substring(startOffset)}
      """,
    );
    Process.run("dart", ["format", routeGenPath]);
  }
}

/// List the top lever functions of a [parsedFile]
List<FunctionDeclaration> listRouters({
  required ParseStringResult parsedFile,
}) {
  final routers = <FunctionDeclaration>[];
  for (final declaration in parsedFile.unit.declarations) {
    if (declaration is FunctionDeclaration) {
      routers.add(declaration);
    }
  }

  return routers;
}

/// Find the path to the route_generator.dart.
///
/// [outputDir] is the starting point. Loop back and find the pubspec.yaml (root)
/// then appends the path to the generator.
String findGeneratorPath({required String outputDir, required Logger logger}) {
  final projectRoot = findProjectRoot(Directory(outputDir));
  final defaultPath =
      path.join(projectRoot.path, "lib/navigation/route_generator.dart");
  final routeGenPath =
      logger.prompt("Path to route_generator.dart", defaultValue: defaultPath);
  return routeGenPath;
}
