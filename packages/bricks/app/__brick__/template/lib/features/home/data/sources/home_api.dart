import 'package:dio/dio.dart';
import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import '../../data/sources/home_source.dart';
import '../../domain/models/home_model.dart';

/// [ApiHomeDataSource] is a class that implements [HomeDataSource] interface.
class ApiHomeDataSource implements HomeDataSource {
  /// [dio] is an instance of [Dio],used for http requests.
  final Dio dio;

  /// [baseUrl] is a [String] that represents the base url of the API.
  final String baseUrl;

  /// [ApiHomeDataSource] constructor.
  ApiHomeDataSource(this.baseUrl) : dio = Dio();

  @override
  Future<List<HomeModel?>> fetchHomeModels() async {
    try {
      final response = await dio.get<List<Map<String, dynamic>>>(
        '$baseUrl/home',
      );
      final homeDataList = response.data;
      final homes = homeDataList?.map(HomeModel.fromJson).toList() ?? [];

      AppLogger.print("API RESULT: Homes fetched: ${homes.map((e) => e.toString())}", [AppLoggerFeatures.home]);
      return homes;
    } catch (e) {
      AppLogger.print("API RESULT: Failed to fetch Homes: $e", [AppLoggerFeatures.home], type: LoggerType.error);
      return [];
    }
  }

  @override
  Future<HomeModel?> fetchHomeModelById(String id) async {
    try {
      final response = await dio.get<Map<String, dynamic>>('$baseUrl/home/$id');
      final responseData = response.data;
      if (responseData != null) {
        final home = HomeModel.fromJson(responseData);
        AppLogger.print("API RESULT: Home fetched by ID: $home", [AppLoggerFeatures.home]);
        return home;
      } else {
        AppLogger.print("API RESULT: Response data is null", [AppLoggerFeatures.home], type: LoggerType.error);
        return null;
      }
    } catch (e) {
      AppLogger.print("API RESULT: Failed to fetch Home by ID: $e", [AppLoggerFeatures.home], type: LoggerType.error);
      return null;
    }
  }

  @override
  Future<void> addHomeModel(HomeModel home) async {
    try {
      await dio.post<bool>(
        '$baseUrl/home',
        data: home.toJson(),
      );
      AppLogger.print("API RESULT: Home added successfully", [AppLoggerFeatures.home], type: LoggerType.confirmation);
    } catch (e) {
      AppLogger.print("API RESULT: Failed to add Home: $e", [AppLoggerFeatures.home], type: LoggerType.error);
    }
  }

  @override
  Future<void> updateHomeModel(HomeModel home) async {
    try {
      await dio.put<bool>(
        '$baseUrl/home/${home.name}',
        data: home.toJson(),
      );
      AppLogger.print("API RESULT: Home updated successfully", [AppLoggerFeatures.home], type: LoggerType.confirmation);
    } catch (e) {
      AppLogger.print("API RESULT: Failed to update Home: $e", [AppLoggerFeatures.home], type: LoggerType.error);
    }
  }

  @override
  Future<void> deleteHomeModel(String id) async {
    try {
      await dio.delete<bool>('$baseUrl/home/$id');
      AppLogger.print("API RESULT: Home deleted successfully", [AppLoggerFeatures.home], type: LoggerType.confirmation);
    } catch (e) {
      AppLogger.print("API RESULT: Failed to delete Home: $e", [AppLoggerFeatures.home], type: LoggerType.error);
    }
  }
}
