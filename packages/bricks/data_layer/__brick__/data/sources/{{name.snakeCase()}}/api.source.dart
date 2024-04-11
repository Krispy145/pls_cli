
import 'package:utilities/data_sources/remote/api.dart';
import 'package:utilities/logger/logger.dart';

import '../../models/{{name.snakeCase()}}_model.dart';
import '../../../dependencies/injection.dart';
import 'package:name_template/utils/loggers.dart';
import '_source.dart';

/// [Api{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Api{{name.pascalCase()}}DataSource extends ApiDataSource<{{name.pascalCase()}}Model> implements {{name.pascalCase()}}DataSource {
  /// [Api{{name.pascalCase()}}DataSource] constructor.
  Api{{name.pascalCase()}}DataSource()
      : super(
          Managers.config.apiPrefix,
          sourceSuffix: "{{name.snakeCase()}}",
          convertDataTypeFromMap: {{name.pascalCase()}}Model.fromJson,
          convertDataTypeToMap: (data) => data.toJson(),
        );

  /// [_handleError] is an optional helper method that handles errors when calling the API.
  // ignore: unused_element
  Future<T?> _handleError<T>(Future<T?> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (e) {
      AppLogger.print(
        "API RESULT: Failed request: $e",
        [NameTemplateLoggers.{{name.camelCase()}}],
        type: LoggerType.error,
      );
      return null;
    }
  }
}
