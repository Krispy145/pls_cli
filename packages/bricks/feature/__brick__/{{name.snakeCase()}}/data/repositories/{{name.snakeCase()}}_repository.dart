import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/data/sources/source.dart';
import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/domain/models/model.dart';
import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/domain/repositories/repository.dart';

class {{name.titleCase()}}DataRepository implements {{name.titleCase()}}Repository {
  final {{name.titleCase()}}DataSource dataSource;

  {{name.titleCase()}}DataRepository(this.dataSource);

  @override
  Future<List<{{name.titleCase()}}Model>> getAll{{name.titleCase()}}Models() async {
    return await dataSource.fetch{{name.titleCase()}}s();
  }

  @override
  Future<{{name.titleCase()}}Model> get{{name.titleCase()}}ModelById(String id) async {
    return await dataSource.fetch{{name.titleCase()}}ById(id);
  }

  @override
  Future<void> add{{name.titleCase()}}Model({{name.titleCase()}}Model {{name.camelCase()}}) async {
    await dataSource.add{{name.titleCase()}}({{name.camelCase()}});
  }

  @override
  Future<void> update{{name.titleCase()}}Model({{name.titleCase()}}Model {{name.camelCase()}}) async {
    await dataSource.update{{name.titleCase()}}({{name.camelCase()}});
  }

  @override
  Future<void> delete{{name.titleCase()}}Model(String id) async {
    await dataSource.delete{{name.titleCase()}}(id);
  }
}
