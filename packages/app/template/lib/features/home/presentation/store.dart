import 'package:mobx/mobx.dart';
import 'package:app_template/dependencies/injection.dart';
import 'package:app_template/features/home/data/sources/home_api.dart';
import 'package:utilities/widgets/load_state/base_store.dart';

import '../data/repositories/home_repository.dart';
import '../data/sources/home_local.dart';
import '../domain/models/home_model.dart';
import '../domain/repositories/home_repository.dart';

part 'store.g.dart';

/// [HomeStore] is a class that uses [HomeBaseStore] to manage state of the main feature.
class HomeStore = HomeBaseStore with _$HomeStore;

/// [HomeBaseStore] is a class that manages the state of the main feature.
abstract class HomeBaseStore extends LoadStateStore with Store {
  /// connectionStatus is an instance of ConnectionStateStore, which is used to determine the current connection state.
  final connectionStatus = Managers.connectionStateStore;

  /// [repository] is an instance of [HomeRepository], which takes in the appropriate DataSource.
  /// This can be in memory or an api.
  /// TODO: Replace "baseUrl" with the appropriate url.
  @computed
  HomeRepository get repository => connectionStatus.handleConnectionSource(
        source:
            HomeDataRepository.api(apiDataSource: ApiHomeDataSource("baseUrl")),
        offlineBackup:
            HomeDataRepository.local(localDataSource: LocalHomeDataSource()),
      );

  /// [homes] is an observable list of [HomeModel]s.
  @observable
  ObservableList<HomeModel?> homes = ObservableList<HomeModel?>();

  /// [loadHomeModels] loads all [HomeModel]s from the data source.
  @action
  Future<void> loadHomeModels() async {
    try {
      setLoading();
      final loadedHomes = await repository.getAllHomeModels();
      if (loadedHomes.isNotEmpty) {
        homes
          ..clear()
          ..addAll(loadedHomes);
        setLoaded();
      } else {
        setEmpty();
      }
    } catch (e) {
      setError();
    }
  }
}
