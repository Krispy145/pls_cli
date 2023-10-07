import '../../domain/models/{{name.snakeCase()}}_model.dart';

abstract class {{name.pascalCase()}}DataSource {
  Future<List<{{name.pascalCase()}}Model>> fetch{{name.pascalCase()}}Models();
  Future<{{name.pascalCase()}}Model> fetch{{name.pascalCase()}}ModelById(String id);
  Future<void> add{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}});
  Future<void> update{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}});
  Future<void> delete{{name.pascalCase()}}Model(String id);
}
