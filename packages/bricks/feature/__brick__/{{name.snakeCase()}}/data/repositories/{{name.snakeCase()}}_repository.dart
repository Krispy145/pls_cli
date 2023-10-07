import '../../data/sources/{{name.snakeCase()}}_source.dart';
import '../../domain/models/{{name.snakeCase()}}_model.dart';
import '../../domain/repositories/{{name.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}DataRepository implements {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}DataSource dataSource;

  {{name.pascalCase()}}DataRepository(this.dataSource);

  @override
  Future<List<{{name.pascalCase()}}Model>> getAll{{name.pascalCase()}}Models() async {
    return await dataSource.fetch{{name.pascalCase()}}s();
  }

  @override
  Future<{{name.pascalCase()}}Model> get{{name.pascalCase()}}ModelById(String id) async {
    return await dataSource.fetch{{name.pascalCase()}}ById(id);
  }

  @override
  Future<void> add{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    await dataSource.add{{name.pascalCase()}}({{name.camelCase()}});
  }

  @override
  Future<void> update{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}) async {
    await dataSource.update{{name.pascalCase()}}({{name.camelCase()}});
  }

  @override
  Future<void> delete{{name.pascalCase()}}Model(String id) async {
    await dataSource.delete{{name.pascalCase()}}(id);
  }
}
