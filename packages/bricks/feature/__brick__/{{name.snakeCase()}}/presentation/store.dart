import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/data/repositories/repository.dart';
import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/data/sources/in_memory.dart';
import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/data/sources/source.dart';
import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/domain/models/model.dart';
import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/domain/repositories/repository.dart';
import 'package:mobx/mobx.dart';

part 'store.g.dart';

class {{name.titleCase()}}Store = _{{name.titleCase()}}Store with _${{name.titleCase()}}Store;

abstract class _{{name.titleCase()}}Store with Store {
  final {{name.titleCase()}}DataSource dataSource = InMemory{{name.titleCase()}}DataSource();
  {{name.titleCase()}}Repository get repository => {{name.titleCase()}}DataRepository(dataSource);

  _{{name.titleCase()}}Store();

  @observable
  ObservableList<{{name.titleCase()}}Model> {{name.camelCase()}}s = ObservableList<{{name.titleCase()}}Model>();

  @action
  Future<void> load{{name.titleCase()}}s() async {
    final loaded{{name.titleCase()}}s = await repository.getAll{{name.titleCase()}}s();
    {{name.camelCase()}}s.clear();
    {{name.camelCase()}}s.addAll(loaded{{name.titleCase()}}s);
  }
}
