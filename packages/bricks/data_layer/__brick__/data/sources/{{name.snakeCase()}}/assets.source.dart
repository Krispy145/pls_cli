import 'package:name_template/utils/loggers.dart';
import 'package:utilities/data_sources/local/assets.dart';
import 'package:utilities/logger/logger.dart';

import '../../models/{{name.snakeCase()}}_model.dart';
import '_source.dart';

/// [Assets{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Assets{{name.pascalCase()}}DataSource extends AssetsDataSource<{{name.pascalCase()}}Model> implements {{name.pascalCase()}}DataSource {
  /// [Assets{{name.pascalCase()}}DataSource] constructor.
  Assets{{name.pascalCase()}}DataSource()
      : super(
          //TODO: Replace the following key with the actual assets key.
          rootBundleKey: 'assets/{{name.snakeCase()}}/list.json',
          convertDataTypeFromMap: {{name.pascalCase()}}Model.fromMap,
          convertDataTypeToMap: (data) => data.toMap(),
        );


  /// [_handleError] is an optional helper method that handles errors when calling ASSETS.
  // ignore: unused_element
  Future<T?> _handleError<T>(Future<T?> Function() assetsCall) async {
    try {
      return await assetsCall();
    } catch (e) {
      AppLogger.print(
        "ASSETS RESULT: Failed request: $e",
        [NameTemplateLoggers.{{name.camelCase()}}],
        type: LoggerType.error,
      );
      return null;
    }
  }
}
