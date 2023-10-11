import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import '../../data/sources/main_source.dart';
import '../../domain/models/main_model.dart';

/// [InMemoryMainDataSource] is a class that implements [MainDataSource] interface.
class InMemoryMainDataSource implements MainDataSource {
  // Simulated in-memory data store
  final Map<String, MainModel> _dataStore = {};

  @override
  Future<List<MainModel?>> fetchMainModels() async {
    try {
      final mains = _dataStore.values.toList();
      Logger.print("IN MEMORY RESULT: Fetched all Main models successfully", [AppLoggerFeatures.main]);
      return Future.value(mains);
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error fetching all Main models: $e", [AppLoggerFeatures.main], type: LoggerType.error);
      return [];
    }
  }

  @override
  Future<MainModel?> fetchMainModelById(String id) async {
    try {
      final main = _dataStore[id];
      if (main != null) {
        Logger.print("IN MEMORY RESULT: Fetched Main model by ID successfully: $main", [AppLoggerFeatures.main]);
        return Future.value(main);
      } else {
        Logger.print("IN MEMORY RESULT: Failed to fetch Main model by ID: Feature not found", [AppLoggerFeatures.main], type: LoggerType.error);
        return null;
      }
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error fetching Main model by ID: $e", [AppLoggerFeatures.main], type: LoggerType.error);
      return null;
    }
  }

  @override
  Future<void> addMainModel(MainModel main) async {
    try {
      _dataStore[main.name] = main;
      Logger.print("IN MEMORY RESULT: Added Main model successfully: $main", [AppLoggerFeatures.main]);
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error adding Main model: $e", [AppLoggerFeatures.main], type: LoggerType.error);
    }
  }

  @override
  Future<void> updateMainModel(MainModel main) async {
    try {
      if (_dataStore.containsKey(main.name)) {
        _dataStore[main.name] = main;
        Logger.print("IN MEMORY RESULT: Updated Main model successfully: $main", [AppLoggerFeatures.main]);
      } else {
        Logger.print("Failed to update Main model: Feature not found", [AppLoggerFeatures.main], type: LoggerType.error);
      }
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error updating Main model: $e", [AppLoggerFeatures.main], type: LoggerType.error);
    }
  }

  @override
  Future<void> deleteMainModel(String id) async {
    try {
      final removedmain = _dataStore.remove(id);
      if (removedmain != null) {
        Logger.print("IN MEMORY RESULT: Deleted Main model successfully: $removedmain", [AppLoggerFeatures.main]);
      } else {
        Logger.print("IN MEMORY RESULT: Failed to delete Main model: Feature not found", [AppLoggerFeatures.main], type: LoggerType.error);
      }
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error deleting Main model: $e", [AppLoggerFeatures.main], type: LoggerType.error);
    }
  }
}
