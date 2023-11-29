import 'package:mobx/mobx.dart';
import 'package:utilities/widgets/load_state/base_store.dart';

import '../../../dependencies/injection.dart';
import '../data/repositories/{{name.snakeCase()}}_repository.dart';
import '../data/sources/{{name.snakeCase()}}_api.dart';
import '../data/sources/{{name.snakeCase()}}_local.dart';
import '../domain/models/{{name.snakeCase()}}_model.dart';
import '../domain/repositories/{{name.snakeCase()}}_repository.dart';

part 'store.g.dart';

/// [{{name.pascalCase()}}Store] is a class that uses [{{name.pascalCase()}}BaseStore] to manage state of the main feature.
class {{name.pascalCase()}}Store = {{name.pascalCase()}}BaseStore with _${{name.pascalCase()}}Store;

/// [{{name.pascalCase()}}BaseStore] is a class that manages the state of the main feature.
abstract class {{name.pascalCase()}}BaseStore extends LoadStateStore with Store {
  /// connectionStatus is an instance of ConnectionStateStore, which is used to determine the current connection state.
  final connectionStatus = Managers.connectionStateStore;

  /// [repository] is an instance of [{{name.pascalCase()}}Repository], which takes in the appropriate DataSource.
  /// This can be in memory or an api.
  /// TODO: Replace "baseUrl" with the appropriate url.
  @computed
  {{name.pascalCase()}}Repository get repository => connectionStatus.handleConnectionSource(
        source: {{name.pascalCase()}}DataRepository.api(apiDataSource: Api{{name.pascalCase()}}DataSource("baseUrl")),
        offlineBackup: {{name.pascalCase()}}DataRepository.local(localDataSource: Local{{name.pascalCase()}}DataSource()),
      );

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
