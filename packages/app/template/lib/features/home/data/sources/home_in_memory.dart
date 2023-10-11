import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import '../../data/sources/home_source.dart';
import '../../domain/models/home_model.dart';

/// [InMemoryHomeDataSource] is a class that implements [HomeDataSource] interface.
class InMemoryHomeDataSource implements HomeDataSource {
  // Simulated in-memory data store
  final Map<String, HomeModel> _dataStore = {};

  @override
  Future<List<HomeModel?>> fetchHomeModels() async {
    try {
      final homes = _dataStore.values.toList();
      Logger.print("IN MEMORY RESULT: Fetched all Home models successfully", [AppLoggerFeatures.home]);
      return Future.value(homes);
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error fetching all Home models: $e", [AppLoggerFeatures.home], type: LoggerType.error);
      return [];
    }
  }

  @override
  Future<HomeModel?> fetchHomeModelById(String id) async {
    try {
      final home = _dataStore[id];
      if (home != null) {
        Logger.print("IN MEMORY RESULT: Fetched Home model by ID successfully: $home", [AppLoggerFeatures.home]);
        return Future.value(home);
      } else {
        Logger.print("IN MEMORY RESULT: Failed to fetch Home model by ID: Feature not found", [AppLoggerFeatures.home], type: LoggerType.error);
        return null;
      }
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error fetching Home model by ID: $e", [AppLoggerFeatures.home], type: LoggerType.error);
      return null;
    }
  }

  @override
  Future<void> addHomeModel(HomeModel home) async {
    try {
      _dataStore[home.name] = home;
      Logger.print("IN MEMORY RESULT: Added Home model successfully: $home", [AppLoggerFeatures.home]);
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error adding Home model: $e", [AppLoggerFeatures.home], type: LoggerType.error);
    }
  }

  @override
  Future<void> updateHomeModel(HomeModel home) async {
    try {
      if (_dataStore.containsKey(home.name)) {
        _dataStore[home.name] = home;
        Logger.print("IN MEMORY RESULT: Updated Home model successfully: $home", [AppLoggerFeatures.home]);
      } else {
        Logger.print("Failed to update Home model: Feature not found", [AppLoggerFeatures.home], type: LoggerType.error);
      }
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error updating Home model: $e", [AppLoggerFeatures.home], type: LoggerType.error);
    }
  }

  @override
  Future<void> deleteHomeModel(String id) async {
    try {
      final removedhome = _dataStore.remove(id);
      if (removedhome != null) {
        Logger.print("IN MEMORY RESULT: Deleted Home model successfully: $removedhome", [AppLoggerFeatures.home]);
      } else {
        Logger.print("IN MEMORY RESULT: Failed to delete Home model: Feature not found", [AppLoggerFeatures.home], type: LoggerType.error);
      }
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error deleting Home model: $e", [AppLoggerFeatures.home], type: LoggerType.error);
    }
  }
}
