import 'dart:io';
import "package:path/path.dart" as path;

import 'package:oasis_cli/src/utils/find_project_root.dart';

/// A representation of a feature
class Feature {
  /// Name of the feature
  final String name;

  /// List of nested features
  final List<Feature>? childFeatures;

  /// A representation of a feature
  Feature({required this.name, this.childFeatures});
}

/// List all the features in the project
List<Feature> listFeatures() {
  final projectRoot = findProjectRoot(Directory.current);
  final libDir = Directory(path.join(projectRoot.path, "lib"));
  final features = <Feature>[];
  for (final entity in libDir.listSync()) {
    if (entity is Directory) {
      final name = path.basename(entity.path);
      final subEntities = entity.listSync();
      // Check if there isn't any nested features
      final hasNoNestedFeatures = subEntities.any((e) {
        final name = path.basename(e.path);
        return name == "blocs" || name == "components" || name == "pages" || name == "repositories" || name == "services";
      });
      if (hasNoNestedFeatures) {
        features.add(Feature(name: name));
      } else {
        features.add(
          Feature(
            name: name,
            childFeatures: subEntities.whereType<Directory>().map((e) => Feature(name: path.basename(e.path))).toList(),
          ),
        );
      }
    }
  }
  return features;
}
