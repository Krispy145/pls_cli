import '../../data/sources/{{name.snakeCase()}}_source.dart';
import '../../domain/models/{{name.snakeCase()}}_model.dart';

class InMemory{{name.pascalCase()}}DataSource implements {{name.pascalCase()}}DataSource {
  // Simulated in-memory data store
  final Map<String, {{name.pascalCase()}}Model> _dataStore = {};

  @override
  Future<List<{{name.pascalCase()}}Model>> fetch{{name.pascalCase()}}s() async {
    final List<{{name.pascalCase()}}Model> {{name.camelCase()}}s = _dataStore.values.toList();
    return Future.value({{name.camelCase()}}s);
  }

  @override
  Future<{{name.pascalCase()}}Model> fetch{{name.pascalCase()}}ById(String id) async {
    final {{name.pascalCase()}}Model? {{name.camelCase()}} = _dataStore[id];
    if ({{name.camelCase()}} != null) {
      return Future.value({{name.camelCase()}});
    } else {
      throw Exception('{{name.pascalCase()}} not found');
    }
  }

  @override
  Future<void> add{{name.pascalCase()}}({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    _dataStore[{{name.camelCase()}}.name] = {{name.camelCase()}};
  }

  @override
  Future<void> update{{name.pascalCase()}}({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    if (_dataStore.containsKey({{name.camelCase()}}.name)) {
      _dataStore[{{name.camelCase()}}.name] = {{name.camelCase()}};
    } else {
      throw Exception('{{name.pascalCase()}} not found');
    }
  }

  @override
  Future<void> delete{{name.pascalCase()}}Model(String id) async {
    _dataStore.remove(id);
  }
}
