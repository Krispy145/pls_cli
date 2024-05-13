import "package:mobx/mobx.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:{{project.snakeCase()}}_package/domain/repositories/{{name.snakeCase()}}.repository.dart";
import "package:utilities/widgets/load_state/store.dart";

part "list_store.g.dart";

/// [{{name.pascalCase()}}sStore] is a class that uses [_{{name.pascalCase()}}sStore] to manage state of the {{name.camelCase()}}s feature.
class {{name.pascalCase()}}sStore = _{{name.pascalCase()}}sStore with _${{name.pascalCase()}}sStore;

/// [_{{name.pascalCase()}}sStore] is a class that manages the state of the {{name.camelCase()}}s feature.
abstract class _{{name.pascalCase()}}sStore extends LoadStateStore with Store {
  /// [repository] is an instance of [{{name.pascalCase()}}Repository].
  final {{name.pascalCase()}}Repository repository = {{name.pascalCase()}}Repository();

  /// [{{name.camelCase()}}s] is an observable list of [{{name.pascalCase()}}Model]s.
  @observable
  ObservableList<{{name.pascalCase()}}Model?> {{name.camelCase()}}s = ObservableList<{{name.pascalCase()}}Model?>();

  /// [load{{name.pascalCase()}}Models] loads all [{{name.pascalCase()}}Model]s from the data source.
  @action
  Future<void> load{{name.pascalCase()}}Models() async {
    try {
      setLoading();
      final loaded{{name.pascalCase()}}s = await repository.getAll{{name.pascalCase()}}Models();
      if (loaded{{name.pascalCase()}}s.isNotEmpty) {
        {{name.camelCase()}}s
          ..clear()
          ..addAll(loaded{{name.pascalCase()}}s);
        setLoaded();
      } else {
        setEmpty();
      }
    } catch (e) {
      setError();
    }
  }
}
