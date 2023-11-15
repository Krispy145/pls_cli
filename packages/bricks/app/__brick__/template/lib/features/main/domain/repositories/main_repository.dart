import '../../domain/models/main_model.dart';

/// [MainRepository] is an abstract class that defines the basic CRUD operations for the [MainModel] entity.
abstract class MainRepository {
  /// [getAllMainModels] fetches all [MainModel]s from the data source.
  Future<List<MainModel?>> getAllMainModels();

  /// [getMainModelById] fetches a [MainModel] by its [id] from the data source.
  Future<MainModel?> getMainModelById(String id);

  /// [addMainModel] adds a [MainModel] to the data source.
  Future<void> addMainModel(MainModel main);

  /// [updateMainModel] updates a [MainModel] in the data source.
  Future<void> updateMainModel(MainModel main);

  /// [deleteMainModel] deletes a [MainModel] from the data source.
  Future<void> deleteMainModel(String id);
}
