import 'package:{{project_name.snakeCase()}}/features/main/data/sources/source.dart';
import 'package:{{project_name.snakeCase()}}/features/main/domain/models/model.dart';
import 'package:{{project_name.snakeCase()}}/features/main/domain/repositories/repository.dart';

class MainDataRepository implements MainRepository {
  final MainDataSource dataSource;

  MainDataRepository(this.dataSource);

  @override
  Future<List<MainModel>> getAllMainModels() async {
    return await dataSource.fetchMainModels();
  }

  @override
  Future<MainModel> getMainModelById(String id) async {
    return await dataSource.fetchMainModelById(id);
  }

  @override
  Future<void> addMainModel(MainModel main) async {
    await dataSource.addMainModel(main);
  }

  @override
  Future<void> updateMainModel(MainModel main) async {
    await dataSource.updateMainModel(main);
  }

  @override
  Future<void> deleteMainModel(String id) async {
    await dataSource.deleteMainModel(id);
  }
}
