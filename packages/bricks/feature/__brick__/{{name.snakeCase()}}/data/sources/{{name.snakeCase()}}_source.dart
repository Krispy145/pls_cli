import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/domain/models/model.dart';

abstract class {{name.titleCase()}}DataSource {
  Future<List<{{name.titleCase()}}Model>> fetch{{name.titleCase()}}Models();
  Future<{{name.titleCase()}}Model> fetch{{name.titleCase()}}ModelById(String id);
  Future<void> add{{name.titleCase()}}Model({{name.titleCase()}}Model {{name.camelCase()}});
  Future<void> update{{name.titleCase()}}Model({{name.titleCase()}}Model {{name.camelCase()}});
  Future<void> delete{{name.titleCase()}}Model(String id);
}
