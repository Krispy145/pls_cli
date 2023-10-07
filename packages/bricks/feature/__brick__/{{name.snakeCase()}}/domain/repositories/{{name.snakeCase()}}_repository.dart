import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/domain/models/model.dart';

abstract class {{name.titleCase()}}Repository {
  Future<List<{{name.titleCase()}}Model>> getAll{{name.titleCase()}}Models();
  Future<{{name.titleCase()}}Model> get{{name.titleCase()}}ModelById(String id);
  Future<void> add{{name.titleCase()}}Model({{name.titleCase()}}Model {{name.camelCase()}});
  Future<void> update{{name.titleCase()}}Model({{name.titleCase()}}Model {{name.camelCase()}});
  Future<void> delete{{name.titleCase()}}Model(String id);
}
