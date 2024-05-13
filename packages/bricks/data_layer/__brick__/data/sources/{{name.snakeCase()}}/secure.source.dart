import '../../models/{{name.snakeCase()}}_model.dart';
import "/utils/loggers.dart";
import "package:utilities/data_sources/local/secure.dart";
import "package:utilities/logger/logger.dart";
import "package:utilities/data/models/basic_search_query_model.dart";

import "_source.dart";

/// [Secure{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Secure{{name.pascalCase()}}DataSource extends SecureDataSource<{{name.pascalCase()}}Model, BasicSearchQueryModel> implements {{name.pascalCase()}}DataSource {
  /// [Secure{{name.pascalCase()}}DataSource] constructor.
  Secure{{name.pascalCase()}}DataSource()
      : super(          
          convertDataTypeFromMap: {{name.pascalCase()}}Model.fromMap,
          convertDataTypeToMap: (data) => data.toMap(),
        );

  @override
  Future<{{name.pascalCase()}}Model?> search(BasicSearchQueryModel query) async {
    AppLogger.print(
      "IN MEMORY RESULT: Search not implemented for {{name.pascalCase()}}Model",
      [ParentNameTemplateLoggers.{{name.camelCase()}}],
    );
    return null;
  }

  @override
  Future<List<{{name.pascalCase()}}Model?>> searchAll(BasicSearchQueryModel query) async {
    AppLogger.print(
      "IN MEMORY RESULT: Search all not implemented for {{name.pascalCase()}}Model",
      [ParentNameTemplateLoggers.{{name.camelCase()}}],
    );
    return [];
  }
}
