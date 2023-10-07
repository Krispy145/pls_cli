import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/data/sources/source.dart';
import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/domain/models/model.dart';
import 'package:dio/dio.dart';

class Api{{name.titleCase()}}DataSource implements {{name.titleCase()}}DataSource {
  final Dio dio;
  final String baseUrl;

  Api{{name.titleCase()}}DataSource(this.baseUrl) : dio = Dio();

  @override
  Future<List<{{name.titleCase()}}Model>> fetch{{name.titleCase()}}Models() async {
    try {
      final response = await dio.get('$baseUrl/{{name.snakeCase()}}');
      final List<dynamic> data = response.data;
      final List<{{name.titleCase()}}Model> {{name.camelCase()}}s = data.map((json) => {{name.titleCase()}}Model.fromJson(json)).toList();
      return {{name.camelCase()}}s;
    } catch (e) {
      throw Exception('Failed to fetch {{name.camelCase()}}s: $e');
    }
  }

  @override
  Future<{{name.titleCase()}}Model> fetch{{name.titleCase()}}ModelById(String id) async {
    try {
      final response = await dio.get('$baseUrl/{{name.snakeCase()}}/$id');
      final Map<String, dynamic> data = response.data;
      final {{name.titleCase()}}Model {{name.camelCase()}} = {{name.titleCase()}}Model.fromJson(data);
      return {{name.camelCase()}};
    } catch (e) {
      throw Exception('Failed to fetch {{name.camelCase()}} by ID: $e');
    }
  }

  @override
  Future<void> add{{name.titleCase()}}Model({{name.titleCase()}}Model {{name.camelCase()}}) async {
    try {
      await dio.post(
        '$baseUrl/{{name.snakeCase()}}',
        data: {{name.camelCase()}}.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to add {{name.camelCase()}}: $e');
    }
  }

  @override
  Future<void> update{{name.titleCase()}}Model({{name.titleCase()}}Model {{name.camelCase()}}) async {
    try {
      await dio.put(
        '$baseUrl/{{name.snakeCase()}}/${{{name.camelCase()}}.name}',
        data: {{name.camelCase()}}.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update {{name.camelCase()}}: $e');
    }
  }

  @override
  Future<void> delete{{name.titleCase()}}Model(String id) async {
    try {
      await dio.delete('$baseUrl/{{name.snakeCase()}}/$id');
    } catch (e) {
      throw Exception('Failed to delete {{name.camelCase()}}: $e');
    }
  }
}
