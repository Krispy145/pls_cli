import 'package:socials/utils/loggers.dart';
import 'package:utilities/data_sources/local/hive/hive.dart';
import 'package:utilities/logger/logger.dart';

import '../../models/{{name.snakeCase()}}_model.dart';
import '_source.dart';

/// [Local{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Local{{name.pascalCase()}}DataSource extends HiveDataSource<{{name.pascalCase()}}Model> implements {{name.pascalCase()}}DataSource {
  // Simulated in-memory data store
  final Map<String, {{name.pascalCase()}}Model> _dataStore = {};

  /// [Local{{name.pascalCase()}}DataSource] constructor.
  Local{{name.pascalCase()}}DataSource()
      : super(
          'socials',
          convertDataTypeFromMap: {{name.pascalCase()}}Model.fromMap,
          convertDataTypeToMap: (data) => data.toMap(),
        );

  @override
  Future<{{name.pascalCase()}}Model?> search(Map<String, dynamic> queries) async {
    try {
      final results = await searchAll(queries);
      return results.firstOrNull;
    } catch (e) {
      AppLogger.print(
        "IN MEMORY RESULT: Error fetching all {{name.pascalCase()}} models: $e",
        [{{name.pascalCase()}}Loggers.socials],
        type: LoggerType.error,
      );
      return null;
    }
  }

  @override
  Future<List<{{name.pascalCase()}}Model?>> searchAll(Map<String, dynamic> queries) async {
    try {
      final shops = _dataStore.values.toList();
      AppLogger.print(
        "IN MEMORY RESULT: Fetched all {{name.pascalCase()}} models successfully",
        [{{name.pascalCase()}}Loggers.socials],
      );
      return Future.value(shops);
    } catch (e) {
      AppLogger.print(
        "IN MEMORY RESULT: Error fetching all {{name.pascalCase()}} models: $e",
        [{{name.pascalCase()}}Loggers.socials],
        type: LoggerType.error,
      );
      return [];
    }
  }
}
