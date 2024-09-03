import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:{{project.snakeCase()}}_package/domain/repositories/{{name.snakeCase()}}.repository.dart";
import "package:mobx/mobx.dart";
import "package:utilities/layouts/paginated_list/store.dart";

part "list_store.g.dart";

/// [{{name.pascalCase()}}sStore] is a class that uses [_{{name.pascalCase()}}sStore] to manage state of the {{name.camelCase()}}s feature.
class {{name.pascalCase()}}sStore = _{{name.pascalCase()}}sStore with _${{name.pascalCase()}}sStore;

/// [_{{name.pascalCase()}}sStore] is a class that manages the state of the {{name.camelCase()}}s feature.
abstract class _{{name.pascalCase()}}sStore extends PaginatedListStore<{{name.pascalCase()}}Model> with Store {
  @override
  late final loadMoreFromRepository = repository.getPaged{{name.pascalCase()}}Models;

  /// [repository] is an instance of [{{name.pascalCase()}}Repository].
  final {{name.pascalCase()}}Repository repository = {{name.pascalCase()}}Repository();

  /// [load{{name.pascalCase()}}Models] loads all [{{name.pascalCase()}}Model]s from the data source.
  @action
  Future<void> load{{name.pascalCase()}}Models() async {
    try {
      setLoading();
      final loaded{{name.pascalCase()}}s = await repository.getAll{{name.pascalCase()}}Models();
      if (loaded{{name.pascalCase()}}s.second.isNotEmpty) {
        results
          ..clear()
          ..addAll(loaded{{name.pascalCase()}}s.second.whereType<{{name.pascalCase()}}Model>());
        setLoaded();
      } else {
        setEmpty("No {{name.camelCase()}}s found.");
      }
    } catch (e) {
      setError("Failed to load {{name.camelCase()}}s: $e");
    }
  }
}
