import 'package:{{project_name.snakeCase()}}/features/home/data/repositories/repository.dart';
import 'package:{{project_name.snakeCase()}}/features/home/data/sources/in_memory.dart';
import 'package:{{project_name.snakeCase()}}/features/home/data/sources/source.dart';
import 'package:{{project_name.snakeCase()}}/features/home/domain/models/model.dart';
import 'package:{{project_name.snakeCase()}}/features/home/domain/repositories/repository.dart';
import 'package:mobx/mobx.dart';

part 'store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final HomeDataSource dataSource = InMemoryHomeDataSource();
  HomeRepository get repository => HomeDataRepository(dataSource);

  _HomeStore();

  @observable
  ObservableList<HomeModel> homes = ObservableList<HomeModel>();

  @action
  Future<void> loadHomeModels() async {
    final loadedFeatures = await repository.getAllHomeModels();
    homes.clear();
    homes.addAll(loadedFeatures);
  }
}
