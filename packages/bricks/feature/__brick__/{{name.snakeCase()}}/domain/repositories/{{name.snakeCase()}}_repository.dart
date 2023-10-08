import '../../domain/models/{{name.snakeCase()}}_model.dart';

abstract class {{name.pascalCase()}}Repository {
  Future<List<{{name.pascalCase()}}Model>?> getAll{{name.pascalCase()}}Models();
  Future<{{name.pascalCase()}}Model?> get{{name.pascalCase()}}ModelById(String id);
  Future<void> add{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}});
  Future<void> update{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}});
  Future<void> delete{{name.pascalCase()}}Model(String id);
}
