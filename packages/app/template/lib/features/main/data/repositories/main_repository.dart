import '../../domain/models/main_model.dart';
import '../../domain/repositories/main_repository.dart';
import '../sources/main_source.dart';

/// [MainDataRepository] is a class that implements [MainRepository] interface.
class MainDataRepository extends MainRepository {
  /// [dataSource] is an instance of [MainDataSource], specifically the in memory data source.
  final MainDataSource dataSource;

  /// [MainDataRepository] constructor.
  MainDataRepository(this.dataSource);

  @override
  Future<List<MainModel?>> getAllMainModels() async {
    return dataSource.getAll();
  }
}
