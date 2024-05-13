import 'package:utilities/data_sources/remote/supabase.dart';
import 'package:utilities/logger/logger.dart';
import "package:utilities/data/models/basic_search_query_model.dart";
import "package:supabase_flutter/supabase_flutter.dart";

import '../../models/{{name.snakeCase()}}_model.dart';
import 'package:parent_name_template/utils/loggers.dart';
import '_source.dart';

/// [Supabase{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Supabase{{name.pascalCase()}}DataSource extends SupabaseDataSource<{{name.pascalCase()}}Model, BasicSearchQueryModel> implements {{name.pascalCase()}}DataSource {
  /// [Supabase{{name.pascalCase()}}DataSource] constructor.
  Supabase{{name.pascalCase()}}DataSource()
      : super(
          '{{name.camelCase()}}',
          convertDataTypeFromMap: {{name.pascalCase()}}Model.fromMap,
          convertDataTypeToMap: (data) => data.toMap(),
        );

  @override
    SupabaseQueryBuilder buildQuery(BasicSearchQueryModel query, SupabaseQueryBuilder table) {
      // TODO: implement buildQuery
      throw UnimplementedError();
    }

  /// [_handleError] is an optional helper method that handles errors when calling the Supabase.
  // ignore: unused_element
  Future<T?> _handleError<T>(Future<T?> Function() supabaseCall) async {
    try {
      return await supabaseCall();
    } catch (e) {
      AppLogger.print(
        "Supabase RESULT: Failed request: $e",
        [ParentNameTemplateLoggers.{{name.camelCase()}}],
        type: LoggerType.error,
      );
      return null;
    }
  }
}
