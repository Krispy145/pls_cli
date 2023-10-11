import '../../data/sources/home_source.dart';
import '../../domain/models/home_model.dart';
import '../../domain/repositories/home_repository.dart';

/// [HomeDataRepository] is a class that implements [HomeRepository] interface.
class HomeDataRepository implements HomeRepository {
  /// [dataSource] is an instance of [HomeDataSource].
  final HomeDataSource dataSource;

  /// [HomeDataRepository] constructor.
  HomeDataRepository(this.dataSource);

  @override
  Future<List<HomeModel?>> getAllHomeModels() async {
    return dataSource.fetchHomeModels();
  }

  @override
  Future<HomeModel?> getHomeModelById(String id) async {
    return dataSource.fetchHomeModelById(id);
  }

  @override
  Future<void> addHomeModel(HomeModel home) async {
    await dataSource.addHomeModel(home);
  }

  @override
  Future<void> updateHomeModel(HomeModel home) async {
    await dataSource.updateHomeModel(home);
  }

  @override
  Future<void> deleteHomeModel(String id) async {
    await dataSource.deleteHomeModel(id);
  }
}
