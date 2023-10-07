import 'package:flutter_template/features/home/data/sources/source.dart';
import 'package:flutter_template/features/home/domain/models/model.dart';

class InMemoryHomeDataSource implements HomeDataSource {
  // Simulated in-memory data store
  final Map<String, HomeModel> _dataStore = {
    'testOne': HomeModel(name: "Serena Lambert", age: 23),
    'testTwo': HomeModel(name: "David Kisbey-Green", age: 28),
  };
  @override
  Future<List<HomeModel>> fetchHomeModels() async {
    final homes = _dataStore.values.toList();
    return Future.value(homes);
  }

  @override
  Future<HomeModel> fetchHomeModelById(String id) async {
    final HomeModel? home = _dataStore[id];
    if (home != null) {
      return Future.value(home);
    } else {
      throw Exception('HomeModel not found');
    }
  }

  @override
  Future<void> addHomeModel(HomeModel home) async {
    _dataStore[home.name] = home;
  }

  @override
  Future<void> updateHomeModel(HomeModel home) async {
    if (_dataStore.containsKey(home.name)) {
      _dataStore[home.name] = home;
    } else {
      throw Exception('HomeModel not found');
    }
  }

  @override
  Future<void> deleteHomeModel(String id) async {
    _dataStore.remove(id);
  }
}
