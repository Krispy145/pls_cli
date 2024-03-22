import 'package:utilities/data_sources/local/hive.dart';
import 'package:utilities/logger/logger.dart';

import '../../models/{{name.snakeCase()}}_model.dart';
import '../../../utils/logger_features.dart';
import '_source.dart';

/// [Local{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Local{{name.pascalCase()}}DataSource extends LocalDataSource<{{name.pascalCase()}}Model> implements {{name.pascalCase()}}DataSource {
  // Simulated in-memory data store
  final Map<String, {{name.pascalCase()}}Model> _dataStore = {};

  /// [Local{{name.pascalCase()}}DataSource] constructor.
  Local{{name.pascalCase()}}DataSource()
      : super(
          '{{name.snakeCase()}}',
          convertDataTypeFromMap: {{name.pascalCase()}}Model.fromJson,
          convertDataTypeToMap: (data) => data.toJson(),
        );

  @override
  Future<List<{{name.pascalCase()}}Model?>> search(Map<String, dynamic> queries) async {
    try {
      final {{name.camelCase()}}s = _dataStore.values.toList();
      AppLogger.print(
        "IN MEMORY RESULT: Fetched all {{name.pascalCase()}} models successfully",
        [AppLoggerFeatures.{{name.camelCase()}}],
      );
      return Future.value({{name.camelCase()}}s);
    } catch (e) {
      AppLogger.print(
        "IN MEMORY RESULT: Error fetching all {{name.pascalCase()}} models: $e",
        [AppLoggerFeatures.{{name.camelCase()}}],
        type: LoggerType.error,
      );
      return [];
    }
  }
}
