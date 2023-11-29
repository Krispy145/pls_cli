import 'package:app_template/dependencies/injection.dart';
import 'package:app_template/features/main/data/sources/main_api.dart';
import 'package:mobx/mobx.dart';
import 'package:utilities/widgets/load_state/base_store.dart';

import '../data/repositories/main_repository.dart';
import '../data/sources/main_local.dart';
import '../domain/models/main_model.dart';
import '../domain/repositories/main_repository.dart';

part 'store.g.dart';

/// [MainStore] is a class that uses [MainBaseStore] to manage state of the main feature.
class MainStore = MainBaseStore with _$MainStore;

/// [MainBaseStore] is a class that manages the state of the main feature.
abstract class MainBaseStore extends LoadStateStore with Store {
  /// connectionStatus is an instance of ConnectionStateStore, which is used to determine the current connection state.
  final connectionStatus = Managers.connectionStateStore;

  /// [repository] is an instance of [MainRepository], which takes in the appropriate DataSource.
  /// This can be in memory or an api.
  /// TODO: Replace "baseUrl" with the appropriate url.
  @computed
  MainRepository get repository => connectionStatus.handleConnectionSource(
        source: MainDataRepository.api(apiDataSource: ApiMainDataSource("baseUrl")),
        offlineBackup: MainDataRepository.local(localDataSource: LocalMainDataSource()),
      );

  /// [mains] is an observable list of [MainModel]s.
  @observable
  ObservableList<MainModel?> mains = ObservableList<MainModel?>();

  /// [loadMainModels] loads all [MainModel]s from the data source.
  @action
  Future<void> loadMainModels() async {
    try {
      setLoading();
      final loadedMains = await repository.getAllMainModels();
      if (loadedMains.isNotEmpty) {
        mains
          ..clear()
          ..addAll(loadedMains);
        setLoaded();
      } else {
        setEmpty();
      }
    } catch (e) {
      setError();
    }
  }
}
