import 'package:flutter_template/features/main/data/sources/source.dart';
import 'package:flutter_template/features/main/domain/models/model.dart';
import 'package:dio/dio.dart';

class ApiMainDataSource implements MainDataSource {
  final Dio dio;
  final String baseUrl;

  ApiMainDataSource(this.baseUrl) : dio = Dio();

  @override
  Future<List<MainModel>> fetchMainModels() async {
    try {
      final response = await dio.get('$baseUrl/Mains');
      final List<dynamic> data = response.data;
      final List<MainModel> mainModels = data.map((json) => MainModel.fromJson(json)).toList();
      return mainModels;
    } catch (e) {
      throw Exception('Failed to fetch Mains: $e');
    }
  }

  @override
  Future<MainModel> fetchMainModelById(String id) async {
    try {
      final response = await dio.get('$baseUrl/mains/$id');
      final Map<String, dynamic> data = response.data;
      final MainModel mainModel = MainModel.fromJson(data);
      return mainModel;
    } catch (e) {
      throw Exception('Failed to fetch Main by ID: $e');
    }
  }

  @override
  Future<void> addMainModel(MainModel main) async {
    try {
      await dio.post(
        '$baseUrl/mains',
        data: main.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to add Main: $e');
    }
  }

  @override
  Future<void> updateMainModel(MainModel main) async {
    try {
      await dio.put(
        '$baseUrl/Mains/${main.name}',
        data: main.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update Main: $e');
    }
  }

  @override
  Future<void> deleteMainModel(String id) async {
    try {
      await dio.delete('$baseUrl/mains/$id');
    } catch (e) {
      throw Exception('Failed to delete Main: $e');
    }
  }
}
