import '../../domain/models/home_model.dart';

/// [HomeDataSource] is an abstract class that defines the basic CRUD operations for the [HomeModel] entity.
abstract class HomeDataSource {
  /// [fetchHomeModels] fetches all [HomeModel]s from the data source.
  Future<List<HomeModel?>> fetchHomeModels();

  /// [fetchHomeModelById] fetches a [HomeModel] by its [id] from the data source.
  Future<HomeModel?> fetchHomeModelById(String id);

  /// [addHomeModel] adds a [HomeModel] to the data source.
  Future<void> addHomeModel(HomeModel home);

  /// [updateHomeModel] updates a [HomeModel] in the data source.
  Future<void> updateHomeModel(HomeModel home);

  /// [deleteHomeModel] deletes a [HomeModel] from the data source.
  Future<void> deleteHomeModel(String id);
}
