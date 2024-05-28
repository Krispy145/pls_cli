import "package:mobx/mobx.dart";
import "package:utilities/data/models/{{name.snakeCase()}}_model.dart";
import "package:utilities/layouts/paginated_list/store.dart";

import "/domain/repositories/{{name.snakeCase()}}.repository.dart";

part "store.g.dart";

/// [{{name.pascalCase()}}sStore] is a class that uses [_{{name.pascalCase()}}sStore] to manage state of the {{name.camelCase()}} feature.
class {{name.pascalCase()}}sStore = _{{name.pascalCase()}}sStore with _${{name.pascalCase()}}sStore;

/// [_{{name.pascalCase()}}sStore] is a class that manages the state of the permission feature.
abstract class _{{name.pascalCase()}}sStore extends PaginatedListStore<{{name.pascalCase()}}Model> with Store {
  /// [repository] is an instance of [{{name.pascalCase()}}Repository].
  final {{name.pascalCase()}}Repository repository = {{name.pascalCase()}}Repository();

  @override
  late final loadMoreFromRepository = repository.getPaged{{name.pascalCase()}}Models;

  /// [load{{name.pascalCase()}}Models] loads all [{{name.pascalCase()}}Model]s from the data source.
  @action
  Future<void> load{{name.pascalCase()}}Models() async {
    try {
      setLoading();
      final loaded{{name.pascalCase()}}s = await repository.getAll{{name.pascalCase()}}Models();
      if (loaded{{name.pascalCase()}}s.isNotEmpty) {
        results
          ..clear()
          ..addAll(loaded{{name.pascalCase()}}s);
        setLoaded();
      } else {
        results.clear();
        setEmpty();
      }
    } catch (e) {
      setError();
    }
  }
}
