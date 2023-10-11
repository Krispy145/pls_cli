import 'package:mobx/mobx.dart';
import 'package:utilities/widgets/load_state/base_store.dart';

import '../data/repositories/home_repository.dart';
import '../data/sources/home_in_memory.dart';
import '../data/sources/home_source.dart';
import '../domain/models/home_model.dart';
import '../domain/repositories/home_repository.dart';

part 'store.g.dart';

/// [HomeStore] is a class that uses [HomeBaseStore] to manage state of the home feature.
class HomeStore = HomeBaseStore with _$HomeStore;

/// [HomeBaseStore] is a class that manages the state of the home feature.
abstract class HomeBaseStore extends LoadStateStore with Store {
  /// [dataSource] is an instance of [HomeDataSource], specifically the in memory data source.
  final HomeDataSource dataSource = InMemoryHomeDataSource();

  /// [repository] is an instance of [HomeRepository], which takes in the appropriate [dataSource].
  /// This can be in memory or an api.
  HomeRepository get repository => HomeDataRepository(dataSource);

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
