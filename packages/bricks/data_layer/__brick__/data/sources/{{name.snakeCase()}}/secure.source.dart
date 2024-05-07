import '../../models/{{name.snakeCase()}}_model.dart';
import "/utils/loggers.dart";
import "package:utilities/data_sources/local/secure.dart";
import "package:utilities/logger/logger.dart";

import "_source.dart";

/// [Secure{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Secure{{name.pascalCase()}}DataSource extends SecureDataSource<{{name.pascalCase()}}UserModel> {
  /// [Secure{{name.pascalCase()}}DataSource] constructor.
  Secure{{name.pascalCase()}}DataSource()
      : super(          
          convertDataTypeFromMap: {{name.pascalCase()}}UserModel.fromMap,
          convertDataTypeToMap: (data) => data.toMap(),
        );

  @override
  Future<{{name.pascalCase()}}UserModel?> search(Map<String, dynamic> queries) async {
    AppLogger.print(
      "IN MEMORY RESULT: Search not implemented for {{name.pascalCase()}}UserModel",
      [NameTemplateLoggers.{{name.camelCase()}}],
    );
    return null;
  }

  @override
  Future<List<{{name.pascalCase()}}UserModel?>> searchAll(Map<String, dynamic> queries) async {
    AppLogger.print(
      "IN MEMORY RESULT: Search all not implemented for {{name.pascalCase()}}UserModel",
      [NameTemplateLoggers.{{name.camelCase()}}],
    );
    return [];
  }
}
