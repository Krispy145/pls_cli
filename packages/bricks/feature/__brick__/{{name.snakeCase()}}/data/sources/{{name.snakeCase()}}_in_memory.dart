import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/data/sources/source.dart';
import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/domain/models/model.dart';

class InMemory{{name.titleCase()}}DataSource implements {{name.titleCase()}}DataSource {
  // Simulated in-memory data store
  final Map<String, {{name.titleCase()}}Model> _dataStore = {};

  @override
  Future<List<{{name.titleCase()}}Model>> fetch{{name.titleCase()}}s() async {
    final List<{{name.titleCase()}}Model> {{name.camelCase()}}s = _dataStore.values.toList();
    return Future.value({{name.camelCase()}}s);
  }

  @override
  Future<{{name.titleCase()}}Model> fetch{{name.titleCase()}}ById(String id) async {
    final {{name.titleCase()}}Model? {{name.camelCase()}} = _dataStore[id];
    if ({{name.camelCase()}} != null) {
      return Future.value({{name.camelCase()}});
    } else {
      throw Exception('{{name.titleCase()}} not found');
    }
  }

  @override
  Future<void> add{{name.titleCase()}}({{name.titleCase()}}Model {{name.camelCase()}}) async {
    _dataStore[{{name.camelCase()}}.name] = {{name.camelCase()}};
  }

  @override
  Future<void> update{{name.titleCase()}}({{name.titleCase()}}Model {{name.camelCase()}}) async {
    if (_dataStore.containsKey({{name.camelCase()}}.name)) {
      _dataStore[{{name.camelCase()}}.name] = {{name.camelCase()}};
    } else {
      throw Exception('{{name.titleCase()}} not found');
    }
  }

  @override
  Future<void> delete{{name.titleCase()}}Model(String id) async {
    _dataStore.remove(id);
  }
}
