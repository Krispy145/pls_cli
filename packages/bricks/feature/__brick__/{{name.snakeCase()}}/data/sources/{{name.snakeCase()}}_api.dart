import '../../data/sources/{{name.snakeCase()}}_source.dart';
import '../../domain/models/{{name.snakeCase()}}_model.dart';
import 'package:dio/dio.dart';

class Api{{name.pascalCase()}}DataSource implements {{name.pascalCase()}}DataSource {
  final Dio dio;
  final String baseUrl;

  Api{{name.pascalCase()}}DataSource(this.baseUrl) : dio = Dio();

  @override
  Future<List<{{name.pascalCase()}}Model>> fetch{{name.pascalCase()}}Models() async {
    try {
      final response = await dio.get('$baseUrl/{{name.snakeCase()}}');
      final List<dynamic> data = response.data;
      final List<{{name.pascalCase()}}Model> {{name.camelCase()}}s = data.map((json) => {{name.pascalCase()}}Model.fromJson(json)).toList();
      return {{name.camelCase()}}s;
    } catch (e) {
      throw Exception('Failed to fetch {{name.camelCase()}}s: $e');
    }
  }

  @override
  Future<{{name.pascalCase()}}Model> fetch{{name.pascalCase()}}ModelById(String id) async {
    try {
      final response = await dio.get('$baseUrl/{{name.snakeCase()}}/$id');
      final Map<String, dynamic> data = response.data;
      final {{name.pascalCase()}}Model {{name.camelCase()}} = {{name.pascalCase()}}Model.fromJson(data);
      return {{name.camelCase()}};
    } catch (e) {
      throw Exception('Failed to fetch {{name.camelCase()}} by ID: $e');
    }
  }

  @override
  Future<void> add{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
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
  Future<void> update{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
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
  Future<void> delete{{name.pascalCase()}}Model(String id) async {
    try {
      await dio.delete('$baseUrl/{{name.snakeCase()}}/$id');
    } catch (e) {
      throw Exception('Failed to delete {{name.camelCase()}}: $e');
    }
  }
}
