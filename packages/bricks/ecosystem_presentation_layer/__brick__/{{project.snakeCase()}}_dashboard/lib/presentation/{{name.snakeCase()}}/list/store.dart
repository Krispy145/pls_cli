import "package:mobx/mobx.dart";
import "package:{{project.snakeCase()}}_package/presentation/{{name.snakeCase()}}/list_store.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";

part "store.g.dart";

/// [Addit{{name.pascalCase()}}sStore] is a class that uses [_Addit{{name.pascalCase()}}sStore] to manage state of the {{name.camelCase()}}s feature.
class Addit{{name.pascalCase()}}sStore = _Addit{{name.pascalCase()}}sStore with _$Addit{{name.pascalCase()}}sStore;

/// [_Addit{{name.pascalCase()}}sStore] is a class that manages the state of the {{name.camelCase()}}s feature.
abstract class _Addit{{name.pascalCase()}}sStore extends {{name.pascalCase()}}sStore with Store {
  @action
  Future<void> delete{{name.pascalCase()}}Model(String id) async {
    try {
      setLoading();
      await repository.delete{{name.pascalCase()}}Model(id);
      {{name.camelCase()}}s.removeWhere((element) => element!.id == id);
      setLoaded();
    } catch (e) {
      setError();
    }
  }
}
