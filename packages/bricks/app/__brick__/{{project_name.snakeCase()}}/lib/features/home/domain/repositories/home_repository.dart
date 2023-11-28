import '../../data/sources/home_source.dart';
import '../models/home_model.dart';

/// [HomeRepository] is an abstract class that defines the basic CRUD operations for the [HomeModel] entity.
class HomeRepository {
  /// [dataSource] is an instance of [HomeDataSource].
  final HomeDataSource dataSource;

  /// [HomeRepository] constructor.
  HomeRepository(this.dataSource);

  /// [getAllHomeModels] fetches all [HomeModel]s from the data source.
  Future<List<HomeModel?>> getAllHomeModels() {
    return dataSource.getAll();
  }
}
