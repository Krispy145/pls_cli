import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// find the root of a project by looking for closest pubspec.yaml
Directory findProjectRoot(Directory dir, [int tryCount = 0]) {
  // check the current dir fo the pubspec
  if (dir
      .listSync()
      .any((e) => e is File && p.basename(e.path) == "pubspec.yaml")) {
    return dir;
  }
  if (tryCount > 15) throw Exception("No pubspec.yaml found");
  return findProjectRoot(dir.parent, tryCount + 1);
}

/// Find the pubspec.yaml file
File findPubspec({Directory? startDir}) {
  final root = findProjectRoot(startDir ?? Directory.current);
  final pubspecFilePath = p.join(root.path, "pubspec.yaml");
  return File(pubspecFilePath);
}

/// Load pubspec into a read only map
YamlMap loadPubspec({Directory? startDir}) {
  final pubspec = findPubspec(startDir: startDir);
  final pubspecString = pubspec.readAsStringSync();
  return loadYaml(pubspecString) as YamlMap;
}
