import 'package:flutter_template/features/home/domain/models/model.dart';

abstract class HomeRepository {
  Future<List<HomeModel>> getAllHomeModels();
  Future<HomeModel> getHomeModelById(String id);
  Future<void> addHomeModel(HomeModel home);
  Future<void> updateHomeModel(HomeModel home);
  Future<void> deleteHomeModel(String id);
}
