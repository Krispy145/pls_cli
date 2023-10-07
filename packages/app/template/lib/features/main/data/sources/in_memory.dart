import 'package:flutter_template/features/main/data/sources/source.dart';
import 'package:flutter_template/features/main/domain/models/model.dart';

class InMemoryMainDataSource implements MainDataSource {
  // Simulated in-memory data store
  final Map<String, MainModel> _dataStore = {};

  @override
  Future<List<MainModel>> fetchMainModels() async {
    final List<MainModel> mainModels = _dataStore.values.toList();
    return Future.value(mainModels);
  }

  @override
  Future<MainModel> fetchMainModelById(String id) async {
    final MainModel? mainModel = _dataStore[id];
    if (mainModel != null) {
      return Future.value(mainModel);
    } else {
      throw Exception('Main not found');
    }
  }

  @override
  Future<void> addMainModel(MainModel main) async {
    _dataStore[main.name] = main;
  }

  @override
  Future<void> updateMainModel(MainModel main) async {
    if (_dataStore.containsKey(main.name)) {
      _dataStore[main.name] = main;
    } else {
      throw Exception('Main not found');
    }
  }

  @override
  Future<void> deleteMainModel(String id) async {
    _dataStore.remove(id);
  }
}
