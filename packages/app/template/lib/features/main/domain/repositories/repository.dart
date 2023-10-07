import 'package:flutter_template/features/main/domain/models/model.dart';

abstract class MainRepository {
  Future<List<MainModel>> getAllMainModels();
  Future<MainModel> getMainModelById(String id);
  Future<void> addMainModel(MainModel main);
  Future<void> updateMainModel(MainModel main);
  Future<void> deleteMainModel(String id);
}
