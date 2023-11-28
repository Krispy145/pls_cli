import 'package:mobx/mobx.dart';
import 'package:app_template/dependencies/injection.dart';
import 'package:app_template/features/main/data/sources/{{name.snakeCase()}}_api.dart';
import 'package:utilities/widgets/load_state/base_store.dart';

import '../data/repositories/{{name.snakeCase()}}_repository.dart';
import '../data/sources/{{name.snakeCase()}}_in_memory.dart';
import '../data/sources/{{name.snakeCase()}}_source.dart';
import '../domain/models/{{name.snakeCase()}}_model.dart';
import '../domain/repositories/{{name.snakeCase()}}_repository.dart';

part 'store.g.dart';

/// [{{name.pascalCase()}}Store] is a class that uses [{{name.pascalCase()}}BaseStore] to manage state of the main feature.
class {{name.pascalCase()}}Store = {{name.pascalCase()}}BaseStore with _${{name.pascalCase()}}Store;

/// [{{name.pascalCase()}}BaseStore] is a class that manages the state of the main feature.
abstract class {{name.pascalCase()}}BaseStore extends LoadStateStore with Store {
  /// connectionStatus is an instance of ConnectionStateStore, which is used to determine the current connection state.
  final connectionStatus = Managers.connectionStateStore;

  /// [dataSource] is an instance of [{{name.pascalCase()}}DataSource], specifically the in memory data source.
  /// TODO: Replace "baseUrl" with the appropriate url.
  @computed
  {{name.pascalCase()}}DataSource get dataSource => connectionStatus.handleConnectionSource(
        source: Api{{name.pascalCase()}}DataSource("baseUrl"),
        offlineBackup: Local{{name.pascalCase()}}DataSource(),
      );

  /// [repository] is an instance of [{{name.pascalCase()}}Repository], which takes in the appropriate [dataSource].
  /// This can be in memory or an api.
  @computed
  {{name.pascalCase()}}Repository get repository => {{name.pascalCase()}}DataRepository(dataSource);

  /// [mains] is an observable list of [{{name.pascalCase()}}Model]s.
  @observable
  ObservableList<{{name.pascalCase()}}Model?> mains = ObservableList<{{name.pascalCase()}}Model?>();

  /// [load{{name.pascalCase()}}Models] loads all [{{name.pascalCase()}}Model]s from the data source.
  @action
  Future<void> load{{name.pascalCase()}}Models() async {
    try {
      setLoading();
      final loaded{{name.pascalCase()}}s = await repository.getAll{{name.pascalCase()}}Models();
      if (loaded{{name.pascalCase()}}s.isNotEmpty) {
        mains
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
