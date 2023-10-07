import 'package:flutter_template/features/main/domain/models/model.dart';

abstract class MainDataSource {
  Future<List<MainModel>> fetchMainModels();
  Future<MainModel> fetchMainModelById(String id);
  Future<void> addMainModel(MainModel main);
  Future<void> updateMainModel(MainModel main);
  Future<void> deleteMainModel(String id);
}
