import 'package:mobx/mobx.dart';
import 'package:utilities/widgets/load_state/base_store.dart';

import '/data/models/{{name.snakeCase()}}_model.dart';
import '/domain/repositories/{{name.snakeCase()}}.repository.dart';

part 'store.g.dart';

/// [{{name.pascalCase()}}Store] is a class that uses [{{name.pascalCase()}}BaseStore] to manage state of the {{name.camelCase()}} feature.
class {{name.pascalCase()}}Store = {{name.pascalCase()}}BaseStore with _${{name.pascalCase()}}Store;

/// [{{name.pascalCase()}}BaseStore] is a class that manages the state of the {{name.camelCase()}} feature.
abstract class {{name.pascalCase()}}BaseStore extends LoadStateStore with Store {
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
      final loaded{{name.pascalCase()}}s = await repository.getAll{{name.pascalCase()}}ModelsFromApi();
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
