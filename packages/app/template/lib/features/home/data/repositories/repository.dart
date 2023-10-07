import 'package:flutter_template/features/home/data/sources/source.dart';
import 'package:flutter_template/features/home/domain/models/model.dart';
import 'package:flutter_template/features/home/domain/repositories/repository.dart';

class HomeDataRepository implements HomeRepository {
  final HomeDataSource dataSource;

  HomeDataRepository(this.dataSource);

  @override
  Future<List<HomeModel>> getAllHomeModels() async {
    return await dataSource.fetchHomeModels();
  }

  @override
  Future<HomeModel> getHomeModelById(String id) async {
    return await dataSource.fetchHomeModelById(id);
  }

  @override
  Future<void> addHomeModel(HomeModel home) async {
    await dataSource.addHomeModel(home);
  }

  @override
  Future<void> updateHomeModel(HomeModel home) async {
    await dataSource.updateHomeModel(home);
  }

  @override
  Future<void> deleteHomeModel(String id) async {
    await dataSource.deleteHomeModel(id);
  }
}
