import 'package:dio/dio.dart';
import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import '../../data/sources/main_source.dart';
import '../../domain/models/main_model.dart';

/// [ApiMainDataSource] is a class that implements [MainDataSource] interface.
class ApiMainDataSource implements MainDataSource {
  /// [dio] is an instance of [Dio],used for http requests.
  final Dio dio;

  /// [baseUrl] is a [String] that represents the base url of the API.
  final String baseUrl;

  /// [ApiMainDataSource] constructor.
  ApiMainDataSource(this.baseUrl) : dio = Dio();

  @override
  Future<List<MainModel?>> fetchMainModels() async {
    try {
      final response = await dio.get<List<Map<String, dynamic>>>(
        '$baseUrl/main',
      );
      final mainDataList = response.data;
      final mains = mainDataList?.map(MainModel.fromJson).toList() ?? [];

      Logger.print("API RESULT: Mains fetched: ${mains.map((e) => e.toString())}", [AppLoggerFeatures.main]);
      return mains;
    } catch (e) {
      Logger.print("API RESULT: Failed to fetch Mains: $e", [AppLoggerFeatures.main], type: LoggerType.error);
      return [];
    }
  }

  @override
  Future<MainModel?> fetchMainModelById(String id) async {
    try {
      final response = await dio.get<Map<String, dynamic>>('$baseUrl/main/$id');
      final responseData = response.data;
      if (responseData != null) {
        final main = MainModel.fromJson(responseData);
        Logger.print("API RESULT: Main fetched by ID: $main", [AppLoggerFeatures.main]);
        return main;
      } else {
        Logger.print("API RESULT: Response data is null", [AppLoggerFeatures.main], type: LoggerType.error);
        return null;
      }
    } catch (e) {
      Logger.print("API RESULT: Failed to fetch Main by ID: $e", [AppLoggerFeatures.main], type: LoggerType.error);
      return null;
    }
  }

  @override
  Future<void> addMainModel(MainModel main) async {
    try {
      await dio.post<bool>(
        '$baseUrl/main',
        data: main.toJson(),
      );
      Logger.print("API RESULT: Main added successfully", [AppLoggerFeatures.main], type: LoggerType.confirmation);
    } catch (e) {
      Logger.print("API RESULT: Failed to add Main: $e", [AppLoggerFeatures.main], type: LoggerType.error);
    }
  }

  @override
  Future<void> updateMainModel(MainModel main) async {
    try {
      await dio.put<bool>(
        '$baseUrl/main/${main.name}',
        data: main.toJson(),
      );
      Logger.print("API RESULT: Main updated successfully", [AppLoggerFeatures.main], type: LoggerType.confirmation);
    } catch (e) {
      Logger.print("API RESULT: Failed to update Main: $e", [AppLoggerFeatures.main], type: LoggerType.error);
    }
  }

  @override
  Future<void> deleteMainModel(String id) async {
    try {
      await dio.delete<bool>('$baseUrl/main/$id');
      Logger.print("API RESULT: Main deleted successfully", [AppLoggerFeatures.main], type: LoggerType.confirmation);
    } catch (e) {
      Logger.print("API RESULT: Failed to delete Main: $e", [AppLoggerFeatures.main], type: LoggerType.error);
    }
  }
}
