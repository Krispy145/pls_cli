import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

/// Validates the name of a package
bool isValidDirectoryName(String name) {
  final _identifierRegExp = RegExp('[a-z_][a-z0-9_]*');
  final match = _identifierRegExp.matchAsPrefix(name);
  return match != null && match.end == name.length;
}

/// find the root of a project by looking for closest pubspec.yaml
Directory findProjectRoot(Directory dir, [int tryCount = 0]) {
  // check the current dir fo the pubspec
  if (dir.listSync().any((e) => e is File && path.basename(e.path) == "pubspec.yaml")) {
    return dir;
  }
  if (tryCount > 15) throw Exception("No pubspec.yaml found");
  return findProjectRoot(dir.parent, tryCount + 1);
}

/// Find the pubspec.yaml file
File findPubspec({Directory? startDir}) {
  final root = findProjectRoot(startDir ?? Directory.current);
  final pubspecFilePath = path.join(root.path, "pubspec.yaml");
  return File(pubspecFilePath);
}

/// Load pubspec into a read only map
YamlMap loadPubspec({Directory? startDir}) {
  final pubspec = findPubspec(startDir: startDir);
  final pubspecString = pubspec.readAsStringSync();
  return loadYaml(pubspecString) as YamlMap;
}

/// Replace all occurrences of a string in a Directory
Future<void> replaceAllInDirectory(Directory directory, Map<String, String> replacements) async {
  await Future.wait(
    directory.listSync(recursive: true).whereType<File>().map((file) async {
      try {
        var fileContent = await file.readAsString();

        for (final entry in replacements.entries) {
          fileContent = fileContent.replaceAll(entry.key, entry.value);
        }

        file = await file.writeAsString(
          fileContent,
          flush: true,
        );
      } catch (_) {}
    }),
  );
}

/// Find and List all occurrences of a string in a Directory
Future<List<String>> findInDirectory(Directory directory, String search) async {
  final results = <String>[];
  await Future.wait(
    directory.listSync(recursive: true).whereType<File>().map((file) async {
      try {
        final fileContent = await file.readAsString();
        if (fileContent.contains(search)) {
          results.add(file.path);
        }
      } catch (_) {}
    }),
  );
  return results;
}

/// Find and List all occurrence keys and return the line in a Directory
Future<List<String>> findKeyAndCopyLineInDirectory(Directory directory, String search) async {
  final results = <String>[];
  await Future.wait(
    directory.listSync(recursive: true).whereType<File>().map((file) async {
      try {
        final fileContent = await file.readAsLines();
        for (var i = 0; i < fileContent.length; i++) {
          if (fileContent[i].contains(search)) {
            final relativePath = path.relative(file.path, from: directory.path);
            results.add("• ${fileContent[i].trim()}\n  - Line ${i + 1}: $relativePath");
          }
        }
      } catch (_) {}
    }),
  );
  return results;
}

/// Get the root path of the user's home directory
String getRootPath(String relativePath) {
  var rootPath = '';
  if (Platform.isWindows) {
    rootPath = path.join(
      Platform.environment['USERPROFILE']!, // Get the user's profile directory
      relativePath,
    );
  } else if (Platform.isLinux || Platform.isMacOS) {
    rootPath = path.join(
      Platform.environment['HOME']!, // Get the user's home directory
      relativePath,
    );
  }
  return rootPath;
}
