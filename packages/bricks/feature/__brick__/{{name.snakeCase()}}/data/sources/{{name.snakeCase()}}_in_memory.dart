import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import '../../data/sources/{{name.camelCase()}}_source.dart';
import '../../domain/models/{{name.camelCase()}}_model.dart';

/// [InMemory{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class InMemory{{name.pascalCase()}}DataSource implements {{name.pascalCase()}}DataSource {
  // Simulated in-memory data store
  final Map<String, {{name.pascalCase()}}Model> _dataStore = {};

  @override
  Future<List<{{name.pascalCase()}}Model?>> fetch{{name.pascalCase()}}Models() async {
    try {
      final {{name.camelCase()}}s = _dataStore.values.toList();
      AppLogger.print("IN MEMORY RESULT: Fetched all {{name.pascalCase()}} models successfully", [AppLoggerFeatures.{{name.camelCase()}}]);
      return Future.value({{name.camelCase()}}s);
    } catch (e) {
      AppLogger.print("IN MEMORY RESULT: Error fetching all {{name.pascalCase()}} models: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      return [];
    }
  }

  @override
  Future<{{name.pascalCase()}}Model?> fetch{{name.pascalCase()}}ModelById(String id) async {
    try {
      final {{name.camelCase()}} = _dataStore[id];
      if ({{name.camelCase()}} != null) {
        AppLogger.print("IN MEMORY RESULT: Fetched {{name.pascalCase()}} model by ID successfully: ${{name.camelCase()}}", [AppLoggerFeatures.{{name.camelCase()}}]);
        return Future.value({{name.camelCase()}});
      } else {
        AppLogger.print("IN MEMORY RESULT: Failed to fetch {{name.pascalCase()}} model by ID: Feature not found", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
        return null;
      }
    } catch (e) {
      AppLogger.print("IN MEMORY RESULT: Error fetching {{name.pascalCase()}} model by ID: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      return null;
    }
  }

  @override
  Future<void> add{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    try {
      _dataStore[{{name.camelCase()}}.name] = {{name.camelCase()}};
      AppLogger.print("IN MEMORY RESULT: Added {{name.pascalCase()}} model successfully: ${{name.camelCase()}}", [AppLoggerFeatures.{{name.camelCase()}}]);
    } catch (e) {
      AppLogger.print("IN MEMORY RESULT: Error adding {{name.pascalCase()}} model: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }

  @override
  Future<void> update{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    try {
      if (_dataStore.containsKey({{name.camelCase()}}.name)) {
        _dataStore[{{name.camelCase()}}.name] = {{name.camelCase()}};
        AppLogger.print("IN MEMORY RESULT: Updated {{name.pascalCase()}} model successfully: ${{name.camelCase()}}", [AppLoggerFeatures.{{name.camelCase()}}]);
      } else {
        AppLogger.print("Failed to update {{name.pascalCase()}} model: Feature not found", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      }
    } catch (e) {
      AppLogger.print("IN MEMORY RESULT: Error updating {{name.pascalCase()}} model: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }

  @override
  Future<void> delete{{name.pascalCase()}}Model(String id) async {
    try {
      final removed{{name.camelCase()}} = _dataStore.remove(id);
      if (removed{{name.camelCase()}} != null) {
        AppLogger.print("IN MEMORY RESULT: Deleted {{name.pascalCase()}} model successfully: $removed{{name.camelCase()}}", [AppLoggerFeatures.{{name.camelCase()}}]);
      } else {
        AppLogger.print("IN MEMORY RESULT: Failed to delete {{name.pascalCase()}} model: Feature not found", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      }
    } catch (e) {
      AppLogger.print("IN MEMORY RESULT: Error deleting {{name.pascalCase()}} model: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }
}
