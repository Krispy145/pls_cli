import '../../data/sources/main_source.dart';
import '../../domain/models/main_model.dart';

/// [MainRepository] is an abstract class that defines the basic CRUD operations for the [MainModel] entity.
class MainRepository {
  /// [dataSource] is an instance of [MainDataSource].
  final MainDataSource dataSource;

  /// [MainRepository] constructor.
  MainRepository(this.dataSource);

  /// [getAllMainModels] fetches all [MainModel]s from the data source.
  Future<List<MainModel?>> getAllMainModels() {
    return dataSource.getAll();
  }
}
