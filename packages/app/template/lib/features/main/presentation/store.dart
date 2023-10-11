import 'package:mobx/mobx.dart';
import 'package:utilities/widgets/load_state/base_store.dart';

import '../data/repositories/main_repository.dart';
import '../data/sources/main_in_memory.dart';
import '../data/sources/main_source.dart';
import '../domain/models/main_model.dart';
import '../domain/repositories/main_repository.dart';

part 'store.g.dart';

/// [MainStore] is a class that uses [MainBaseStore] to manage state of the main feature.
class MainStore = MainBaseStore with _$MainStore;

/// [MainBaseStore] is a class that manages the state of the main feature.
abstract class MainBaseStore extends LoadStateStore with Store {
  /// [dataSource] is an instance of [MainDataSource], specifically the in memory data source.
  final MainDataSource dataSource = InMemoryMainDataSource();

  /// [repository] is an instance of [MainRepository], which takes in the appropriate [dataSource].
  /// This can be in memory or an api.
  MainRepository get repository => MainDataRepository(dataSource);

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
