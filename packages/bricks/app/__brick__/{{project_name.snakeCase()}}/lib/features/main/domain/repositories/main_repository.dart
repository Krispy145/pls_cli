import '../models/main_model.dart';

/// [MainRepository] is an abstract class that defines the basic CRUD operations for the [MainModel] entity.
abstract class MainRepository {
  /// [MainRepository] constructor.
  MainRepository();

  /// [getAllMainModels] fetches all [MainModel]s from the data source.
  Future<List<MainModel?>> getAllMainModels();
}
