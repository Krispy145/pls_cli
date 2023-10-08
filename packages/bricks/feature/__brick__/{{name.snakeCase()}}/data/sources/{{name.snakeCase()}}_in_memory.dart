import '../../../../utils/logger_features.dart';
import '../../data/sources/{{name.snakeCase()}}_source.dart';
import '../../domain/models/{{name.snakeCase()}}_model.dart';
import 'package:utilities/logger/logger.dart';


class InMemory{{name.pascalCase()}}DataSource implements {{name.pascalCase()}}DataSource {
  // Simulated in-memory data store
  final Map<String, {{name.pascalCase()}}Model> _dataStore = {};

  @override
  Future<List<{{name.pascalCase()}}Model>?> fetch{{name.pascalCase()}}Models() async {
    try{
    final List<{{name.pascalCase()}}Model> {{name.camelCase()}}s = _dataStore.values.toList();
      Logger.print("IN MEMORY RESULT: Fetched all {{name.titleCase()}} models successfully", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.information);
    return Future.value({{name.camelCase()}}s);
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error fetching all {{name.titleCase()}} models: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      return null;
    }
  }

  @override
  Future<{{name.pascalCase()}}Model?> fetch{{name.pascalCase()}}ModelById(String id) async {
    try{
    final {{name.pascalCase()}}Model? {{name.camelCase()}} = _dataStore[id];
    if ({{name.camelCase()}} != null) {
       Logger.print("IN MEMORY RESULT: Fetched {{name.titleCase()}} model by ID successfully: ${{{name.camelCase()}}.toString()}", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.information);
      return Future.value({{name.camelCase()}});
    } else {
      Logger.print("IN MEMORY RESULT: Failed to fetch {{name.titleCase()}} model by ID: Feature not found", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      return null;      
    }
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error fetching {{name.titleCase()}} model by ID: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      return null;
    }
  }

  @override
  Future<void> add{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    try{
    _dataStore[{{name.camelCase()}}.name] = {{name.camelCase()}};
     Logger.print("IN MEMORY RESULT: Added {{name.titleCase()}} model successfully: ${{{name.camelCase()}}.toString()}", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.information);
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error adding {{name.titleCase()}} model: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }

  @override
  Future<void> update{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    try{
    if (_dataStore.containsKey({{name.camelCase()}}.name)) {
      _dataStore[{{name.camelCase()}}.name] = {{name.camelCase()}};
      Logger.print("IN MEMORY RESULT: Updated {{name.titleCase()}} model successfully: ${{{name.camelCase()}}.toString()}", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.information);
    } else {
        Logger.print("Failed to update {{name.titleCase()}} model: Feature not found", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
     } catch (e) {
      Logger.print("IN MEMORY RESULT: Error updating {{name.titleCase()}} model: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }

  @override
  Future<void> delete{{name.pascalCase()}}Model(String id) async {
    try {
      final removed{{name.camelCase()}} = _dataStore.remove(id);
      if (removed{{name.camelCase()}} != null) {
        Logger.print("IN MEMORY RESULT: Deleted {{name.titleCase()}} model successfully: ${removed{{name.camelCase()}}.toString()}", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.information);
      } else {
        Logger.print("IN MEMORY RESULT: Failed to delete {{name.titleCase()}} model: Feature not found", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
      }
    } catch (e) {
      Logger.print("IN MEMORY RESULT: Error deleting {{name.titleCase()}} model: $e", [AppLoggerFeatures.{{name.camelCase()}}], type: LoggerType.error);
    }
  }
}
