import '../../domain/models/home_model.dart';
import '../../domain/repositories/home_repository.dart';

/// [HomeDataRepository] is a class that implements [HomeRepository] interface.
class HomeDataRepository extends HomeRepository {
  /// [HomeDataRepository] constructor.
  HomeDataRepository(super.dataSource);

  @override
  Future<List<HomeModel?>> getAllHomeModels() async {
    return dataSource.getAll();
  }
}
