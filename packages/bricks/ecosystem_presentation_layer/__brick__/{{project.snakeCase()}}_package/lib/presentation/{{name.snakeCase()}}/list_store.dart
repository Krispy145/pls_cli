import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:{{project.snakeCase()}}_package/domain/repositories/{{name.snakeCase()}}.repository.dart";
import "package:mobx/mobx.dart";
import "package:utilities/data/sources/source.dart";
import "package:utilities/helpers/tuples.dart";
import "package:utilities/layouts/paginated_list/store.dart";

part "list_store.g.dart";

part "list_store.g.dart";

/// [{{name.pascalCase()}}sStore] is a class that uses [_{{name.pascalCase()}}sStore] to manage state of the {{name.pascalCase()}}s feature.
class {{name.pascalCase()}}sStore = _{{name.pascalCase()}}sStore with _${{name.pascalCase()}}sStore;

/// [_{{name.pascalCase()}}sStore] is a class that manages the state of the {{name.pascalCase()}}s feature.
/// TODO: change the second type, [String] is the default, in [PaginatedListStore] to the type for the field you want to sort by.
abstract class _{{name.pascalCase()}}sStore extends PaginatedListStore<{{name.pascalCase()}}Model, String> with Store {
  /// [{{name.pascalCase()}}sStore] constructor.
  _{{name.pascalCase()}}sStore({super.shouldLoadMoreInitially = true});

  @override
  Future<Pair<RequestResponse, List<{{name.pascalCase()}}Model?>>> Function({int? limit, bool refresh}) get loadMoreFromRepository => repository.getPaged{{name.pascalCase()}}Models;

  /// [repository] is an instance of [{{name.pascalCase()}}Repository].
  final {{name.pascalCase()}}Repository repository = {{name.pascalCase()}}Repository();
}
