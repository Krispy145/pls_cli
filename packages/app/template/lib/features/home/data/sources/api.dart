import 'package:flutter_template/features/home/data/sources/source.dart';
import 'package:flutter_template/features/home/domain/models/model.dart';
import 'package:dio/dio.dart';

class ApiHomeDataSource implements HomeDataSource {
  final Dio dio;
  final String baseUrl;

  ApiHomeDataSource(this.baseUrl) : dio = Dio();

  @override
  Future<List<HomeModel>> fetchHomeModels() async {
    try {
      final response = await dio.get('$baseUrl/homes');
      final List<dynamic> data = response.data;
      final List<HomeModel> homes = data.map((json) => HomeModel.fromJson(json)).toList();
      return homes;
    } catch (e) {
      throw Exception('Failed to fetch HomeModels: $e');
    }
  }

  @override
  Future<HomeModel> fetchHomeModelById(String id) async {
    try {
      final response = await dio.get('$baseUrl/homes/$id');
      final Map<String, dynamic> data = response.data;
      final HomeModel homeModel = HomeModel.fromJson(data);
      return homeModel;
    } catch (e) {
      throw Exception('Failed to fetch HomeModel by ID: $e');
    }
  }

  @override
  Future<void> addHomeModel(HomeModel homeModel) async {
    try {
      await dio.post(
        '$baseUrl/homes',
        data: homeModel.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to add HomeModel: $e');
    }
  }

  @override
  Future<void> updateHomeModel(HomeModel homeModel) async {
    try {
      await dio.put(
        '$baseUrl/homes/${homeModel.name}',
        data: homeModel.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update HomeModel: $e');
    }
  }

  @override
  Future<void> deleteHomeModel(String id) async {
    try {
      await dio.delete('$baseUrl/homes/$id');
    } catch (e) {
      throw Exception('Failed to delete HomeModel: $e');
    }
  }
}
