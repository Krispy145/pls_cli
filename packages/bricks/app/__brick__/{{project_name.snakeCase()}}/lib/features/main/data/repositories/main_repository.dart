import '../../data/sources/main_source.dart';
import '../../domain/models/main_model.dart';
import '../../domain/repositories/main_repository.dart';

/// [MainDataRepository] is a class that implements [MainRepository] interface.
class MainDataRepository implements MainRepository {
  /// [dataSource] is an instance of [MainDataSource].
  final MainDataSource dataSource;

  /// [MainDataRepository] constructor.
  MainDataRepository(this.dataSource);

  @override
  Future<List<MainModel?>> getAllMainModels() async {
    return dataSource.fetchMainModels();
  }

  @override
  Future<MainModel?> getMainModelById(String id) async {
    return dataSource.fetchMainModelById(id);
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
