import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import '../../data/sources/{{name.snakeCase()}}_source.dart';
import '../../domain/models/{{name.snakeCase()}}_model.dart';
import 'package:dio/dio.dart';

class Api{{name.pascalCase()}}DataSource implements {{name.pascalCase()}}DataSource {
  final Dio dio;
  final String baseUrl;

  Api{{name.pascalCase()}}DataSource(this.baseUrl) : dio = Dio();

  @override
  Future<List<{{name.pascalCase()}}Model>?> fetch{{name.pascalCase()}}Models() async {
    try {
      final response = await dio.get('$baseUrl/{{name.snakeCase()}}');
      final List<dynamic> data = response.data;
      final List<{{name.pascalCase()}}Model> {{name.camelCase()}}s = data.map((json) => {{name.pascalCase()}}Model.fromJson(json)).toList();
      Logger.print("API RESULT: {{name.titleCase()}}s fetched: ${{{name.camelCase()}}s.map((e) => e.toString())} ", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.information);
      return {{name.camelCase()}}s;
    } catch (e) {
       Logger.print("API RESULT: Failed to fetch {{name.titleCase()}}s: $e ", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      return null;      
    }
  }

  @override
  Future<{{name.pascalCase()}}Model?> fetch{{name.pascalCase()}}ModelById(String id) async {
    try {
      final response = await dio.get('$baseUrl/{{name.snakeCase()}}/$id');
      final Map<String, dynamic> data = response.data;
      final {{name.pascalCase()}}Model {{name.camelCase()}} = {{name.pascalCase()}}Model.fromJson(data);
      Logger.print("API RESULT: {{name.titleCase()}} fetched by ID: ${{{name.camelCase()}}.toString()}", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.information);
      return {{name.camelCase()}};
    } catch (e) {
      Logger.print("API RESULT: Failed to fetch {{name.titleCase()}} by ID: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      return null;
      
    }
  }

  @override
  Future<void> add{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    try {
      await dio.post(
        '$baseUrl/{{name.snakeCase()}}',
        data: {{name.camelCase()}}.toJson(),
      );
      Logger.print("API RESULT: {{name.titleCase()}} added successfully", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.confirmation);
    } catch (e) {
      Logger.print("API RESULT: Failed to add {{name.titleCase()}}: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }

  @override
  Future<void> update{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    try {
      await dio.put(
        '$baseUrl/{{name.snakeCase()}}/${{{name.camelCase()}}.name}',
        data: {{name.camelCase()}}.toJson(),
      );
    Logger.print("API RESULT: {{name.titleCase()}} updated successfully", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.confirmation);
    } catch (e) {
      Logger.print("API RESULT: Failed to update {{name.titleCase()}}: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }

  @override
  Future<void> delete{{name.pascalCase()}}Model(String id) async {
    try {
      await dio.delete('$baseUrl/{{name.snakeCase()}}/$id');
    Logger.print("API RESULT: {{name.titleCase()}} deleted successfully", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.confirmation);
    } catch (e) {
      Logger.print("API RESULT: Failed to delete {{name.titleCase()}}: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }
}
