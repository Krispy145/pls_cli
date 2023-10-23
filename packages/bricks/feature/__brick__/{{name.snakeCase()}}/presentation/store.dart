import 'package:app_template/dependencies/injection.dart';
import 'package:app_template/features/{{camelCase()}}/data/sources/{{camelCase()}}_api.dart';
import 'package:mobx/mobx.dart';
import 'package:utilities/widgets/load_state/base_store.dart';

import '../data/repositories/{{camelCase()}}_repository.dart';
import '../data/sources/{{camelCase()}}_in_memory.dart';
import '../data/sources/{{camelCase()}}_source.dart';
import '../domain/models/{{camelCase()}}_model.dart';
import '../domain/repositories/{{camelCase()}}_repository.dart';

part 'store.g.dart';

/// [{{pascalCase()}}Store] is a class that uses [{{pascalCase()}}BaseStore] to manage state of the {{camelCase()}} feature.
class {{pascalCase()}}Store = {{pascalCase()}}BaseStore with _${{pascalCase()}}Store;

/// [{{pascalCase()}}BaseStore] is a class that manages the state of the {{camelCase()}} feature.
class {{pascalCase()}}BaseStore extends LoadStateStore with Store {
  /// connectionStatus is an instance of ConnectionStateStore, which is used to determine the current connection state.
  @observable
  final connectionStatus = Managers.connectionStateStore;

  /// [dataSource] is an instance of [{{pascalCase()}}DataSource], specifically the in memory data source.
  // TODO: Replace "baseUrl" with the appropriate url.
  @computed
  {{pascalCase()}}DataSource get dataSource => connectionStatus.handleConnectionState(
        online: Api{{pascalCase()}}DataSource("baseUrl"),
        offline: InMemory{{pascalCase()}}DataSource(),
      );

  /// [repository] is an instance of [{{pascalCase()}}Repository], which takes in the appropriate [dataSource].
  /// This can be in memory or an api.
  @computed
  {{pascalCase()}}Repository get repository => {{pascalCase()}}DataRepository(dataSource);

  /// [{{camelCase()}}s] is an observable list of [{{pascalCase()}}Model]s.
  @observable
  ObservableList<{{pascalCase()}}Model?> {{camelCase()}}s = ObservableList<{{pascalCase()}}Model?>();

  /// [load{{pascalCase()}}Models] loads all [{{pascalCase()}}Model]s from the data source.
  @action
  Future<void> load{{pascalCase()}}Models() async {
    try {
      setLoading();
      final loaded{{pascalCase()}}s = await repository.getAll{{pascalCase()}}Models();
      if (loaded{{pascalCase()}}s.isNotEmpty) {
        {{camelCase()}}s
          ..clear()
          ..addAll(loaded{{pascalCase()}}s);
        setLoaded();
      } else {
        setEmpty();
      }
    } catch (e) {
      setError();
    }
  }
}
