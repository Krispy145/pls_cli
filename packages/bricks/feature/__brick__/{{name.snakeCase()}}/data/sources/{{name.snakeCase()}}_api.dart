import 'package:dio/dio.dart';
import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import '../../data/sources/{{name.camelCase()}}_source.dart';
import '../../domain/models/{{name.camelCase()}}_model.dart';

/// [Api{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Api{{name.pascalCase()}}DataSource implements {{name.pascalCase()}}DataSource {
  /// [dio] is an instance of [Dio],used for http requests.
  final Dio dio;

  /// [baseUrl] is a [String] that represents the base url of the API.
  final String baseUrl;

  /// [Api{{name.pascalCase()}}DataSource] constructor.
  Api{{name.pascalCase()}}DataSource(this.baseUrl) : dio = Dio();

  @override
  Future<List<{{name.pascalCase()}}Model?>> fetch{{name.pascalCase()}}Models() async {
    try {
      final response = await dio.get<List<Map<String, dynamic>>>(
        '$baseUrl/{{name.camelCase()}}',
      );
      final {{name.camelCase()}}DataList = response.data;
      final {{name.camelCase()}}s = {{name.camelCase()}}DataList?.map({{name.pascalCase()}}Model.fromJson).toList() ?? [];

      Logger.print("API RESULT: {{name.pascalCase()}}s fetched: ${{{name.camelCase()}}s.map((e) => e.toString())}", [AppLoggerFeatures.{{name.camelCase()}}]);
      return {{name.camelCase()}}s;
    } catch (e) {
      Logger.print("API RESULT: Failed to fetch {{name.pascalCase()}}s: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      return [];
    }
  }

  @override
  Future<{{name.pascalCase()}}Model?> fetch{{name.pascalCase()}}ModelById(String id) async {
    try {
      final response = await dio.get<Map<String, dynamic>>('$baseUrl/{{name.camelCase()}}/$id');
      final responseData = response.data;
      if (responseData != null) {
        final {{name.camelCase()}} = {{name.pascalCase()}}Model.fromJson(responseData);
        Logger.print("API RESULT: {{name.pascalCase()}} fetched by ID: ${{name.camelCase()}}", [AppLoggerFeatures.{{name.camelCase()}}]);
        return {{name.camelCase()}};
      } else {
        Logger.print("API RESULT: Response data is null", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
        return null;
      }
    } catch (e) {
      Logger.print("API RESULT: Failed to fetch {{name.pascalCase()}} by ID: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      return null;
    }
  }

  @override
  Future<void> add{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    try {
      await dio.post<bool>(
        '$baseUrl/{{name.camelCase()}}',
        data: {{name.camelCase()}}.toJson(),
      );
      Logger.print("API RESULT: {{name.pascalCase()}} added successfully", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.confirmation);
    } catch (e) {
      Logger.print("API RESULT: Failed to add {{name.pascalCase()}}: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }

  @override
  Future<void> update{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    try {
      await dio.put<bool>(
        '$baseUrl/{{name.camelCase()}}/${{{name.camelCase()}}.name}',
        data: {{name.camelCase()}}.toJson(),
      );
      Logger.print("API RESULT: {{name.pascalCase()}} updated successfully", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.confirmation);
    } catch (e) {
      Logger.print("API RESULT: Failed to update {{name.pascalCase()}}: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }

  @override
  Future<void> delete{{name.pascalCase()}}Model(String id) async {
    try {
      await dio.delete<bool>('$baseUrl/{{name.camelCase()}}/$id');
      Logger.print("API RESULT: {{name.pascalCase()}} deleted successfully", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.confirmation);
    } catch (e) {
      Logger.print("API RESULT: Failed to delete {{name.pascalCase()}}: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }
}
