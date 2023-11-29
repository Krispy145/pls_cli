import '../models/home_model.dart';

/// [HomeRepository] is an abstract class that defines the basic CRUD operations for the [HomeModel] entity.
abstract class HomeRepository {
  /// [HomeRepository] constructor.
  HomeRepository();

  /// [getAllHomeModels] fetches all [HomeModel]s from the data source.
  Future<List<HomeModel?>> getAllHomeModels();
}
