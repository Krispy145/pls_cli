import '../../domain/models/home_model.dart';
import '../../domain/repositories/home_repository.dart';
import '../sources/home_source.dart';

/// [HomeDataRepository] is a class that implements [HomeRepository] interface.
class HomeDataRepository extends HomeRepository {
  /// [dataSource] is an instance of [HomeDataSource], specifically the in memory data source.
  final HomeDataSource dataSource;

  /// [HomeDataRepository] constructor.
  HomeDataRepository(this.dataSource);

  @override
  Future<List<HomeModel?>> getAllHomeModels() async {
    return dataSource.getAll();
  }
}
