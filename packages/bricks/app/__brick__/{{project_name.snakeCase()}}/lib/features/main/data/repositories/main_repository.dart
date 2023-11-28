import '../../domain/models/main_model.dart';
import '../../domain/repositories/main_repository.dart';

/// [MainDataRepository] is a class that implements [MainRepository] interface.
class MainDataRepository extends MainRepository {
  /// [MainDataRepository] constructor.
  MainDataRepository(super.dataSource);

  @override
  Future<List<MainModel?>> getAllMainModels() async {
    return dataSource.getAll();
  }
}
