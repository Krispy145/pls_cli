import "package:mobx/mobx.dart";
import "/data/models/{{name.snakeCase()}}_model.dart";
import "/domain/repositories/{{name.snakeCase()}}.repository.dart";
import "package:utilities/widgets/load_state/store.dart";

part "store.g.dart";

/// [{{name.pascalCase()}}Store] is a class that uses [_{{name.pascalCase()}}Store] to manage state of the {{name.camelCase()}} feature.
class {{name.pascalCase()}}Store = _{{name.pascalCase()}}Store with _${{name.pascalCase()}}Store;

/// [_{{name.pascalCase()}}Store] is a class that manages the state of the {{name.camelCase()}} feature.
abstract class _{{name.pascalCase()}}Store extends LoadStateStore with Store {
  /// [repository] is an instance of [{{name.pascalCase()}}Repository].
  final {{name.pascalCase()}}Repository repository = {{name.pascalCase()}}Repository();

  /// [{{name.camelCase()}}] is an observable list of [{{name.pascalCase()}}Model]s.
  @observable
  ObservableList<{{name.pascalCase()}}Model?> {{name.camelCase()}} = ObservableList<{{name.pascalCase()}}Model?>();

  /// [load{{name.pascalCase()}}Models] loads all [{{name.pascalCase()}}Model]s from the data source.
  @action
  Future<void> load{{name.pascalCase()}}Models() async {
    try {
      setLoading();
      final loaded{{name.pascalCase()}} = await repository.getAll{{name.pascalCase()}}Models();
      if (loaded{{name.pascalCase()}}.isNotEmpty) {
        {{name.camelCase()}}
          ..clear()
          ..addAll(loaded{{name.pascalCase()}});
        setLoaded();
      } else {
        setEmpty();
      }
    } catch (e) {
      setError();
    }
  }
}
