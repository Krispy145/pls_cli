import '../../data/repositories/{{name.snakeCase()}}_repository.dart';
import '../../data/sources/{{name.snakeCase()}}_in_memory.dart';
import '../../data/sources/{{name.snakeCase()}}_source.dart';
import '../../domain/models/{{name.snakeCase()}}_model.dart';
import '../../domain/repositories/{{name.snakeCase()}}_repository.dart';
import 'package:mobx/mobx.dart';

part 'store.g.dart';

class {{name.pascalCase()}}Store = _{{name.pascalCase()}}Store with _${{name.pascalCase()}}Store;

abstract class _{{name.pascalCase()}}Store with Store {
  final {{name.pascalCase()}}DataSource dataSource = InMemory{{name.pascalCase()}}DataSource();
  {{name.pascalCase()}}Repository get repository => {{name.pascalCase()}}DataRepository(dataSource);

  _{{name.pascalCase()}}Store();

  @observable
  ObservableList<{{name.pascalCase()}}Model> {{name.camelCase()}}s = ObservableList<{{name.pascalCase()}}Model>();

  @action
  Future<void> load{{name.pascalCase()}}s() async {
    final loaded{{name.pascalCase()}}s = await repository.getAll{{name.pascalCase()}}s();
    {{name.camelCase()}}s.clear();
    {{name.camelCase()}}s.addAll(loaded{{name.pascalCase()}}s);
  }
}
