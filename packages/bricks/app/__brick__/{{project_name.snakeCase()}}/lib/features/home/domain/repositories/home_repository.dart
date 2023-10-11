import '../../domain/models/home_model.dart';

/// [HomeRepository] is an abstract class that defines the basic CRUD operations for the [HomeModel] entity.
abstract class HomeRepository {
  /// [getAllHomeModels] fetches all [HomeModel]s from the data source.
  Future<List<HomeModel?>> getAllHomeModels();

  /// [getHomeModelById] fetches a [HomeModel] by its [id] from the data source.
  Future<HomeModel?> getHomeModelById(String id);

  /// [addHomeModel] adds a [HomeModel] to the data source.
  Future<void> addHomeModel(HomeModel home);

  /// [updateHomeModel] updates a [HomeModel] in the data source.
  Future<void> updateHomeModel(HomeModel home);

  /// [deleteHomeModel] deletes a [HomeModel] from the data source.
  Future<void> deleteHomeModel(String id);
}
