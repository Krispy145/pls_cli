import 'package:{{project_name.snakeCase()}}/features/home/domain/models/model.dart';

abstract class HomeDataSource {
  Future<List<HomeModel>> fetchHomeModels();
  Future<HomeModel> fetchHomeModelById(String id);
  Future<void> addHomeModel(HomeModel home);
  Future<void> updateHomeModel(HomeModel home);
  Future<void> deleteHomeModel(String id);
}
