import 'package:ansi_styles/extension.dart';
import 'package:oasis_cli/src/commands/base.dart';
import 'package:oasis_cli/src/utils/feature.dart';

/// {@template listFeaturesCommand}
/// List all features in the project
/// {@endtemplate}
class ListFeaturesCommand extends UnpackCommand {
  /// {@macro listFeaturesCommand}
  ListFeaturesCommand();
  @override
  String get description => "List all features of the project";

  @override
  String get name => "features";

  @override
  Future<void> run() async {
    final features = listFeatures();
    const sep = "├── ";
    logger
      ..info("\n")
      ..info("All features:".green);
    for (final feature in features) {
      logger.info(feature.name);

      if (feature.childFeatures != null) {
        for (final child in feature.childFeatures!) {
          logger.info("$sep${child.name}");
        }
      }
    }
  }
}
