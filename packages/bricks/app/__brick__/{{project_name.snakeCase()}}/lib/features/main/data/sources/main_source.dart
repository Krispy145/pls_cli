import '../../domain/models/main_model.dart';

/// [MainDataSource] is an abstract class that defines the basic CRUD operations for the [MainModel] entity.
abstract class MainDataSource {
  /// [fetchMainModels] fetches all [MainModel]s from the data source.
  Future<List<MainModel?>> fetchMainModels();

  /// [fetchMainModelById] fetches a [MainModel] by its [id] from the data source.
  Future<MainModel?> fetchMainModelById(String id);

  /// [addMainModel] adds a [MainModel] to the data source.
  Future<void> addMainModel(MainModel main);

  /// [updateMainModel] updates a [MainModel] in the data source.
  Future<void> updateMainModel(MainModel main);

  /// [deleteMainModel] deletes a [MainModel] from the data source.
  Future<void> deleteMainModel(String id);
}
