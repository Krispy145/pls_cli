import '/data/repositories/_repositories.dart';

import '/data/models/{{name.snakeCase()}}_model.dart';
import '/data/sources/{{name.snakeCase()}}/_source.dart';
import '/data/sources/{{name.snakeCase()}}/api.source.dart';
import '/data/sources/{{name.snakeCase()}}/dummy.source.dart';
import '/data/sources/{{name.snakeCase()}}/firestore.source.dart';
import '/data/sources/{{name.snakeCase()}}/secure.source.dart';

/// [{{name.pascalCase()}}DataSourceTypes] is an enum that defines the different data sources.
enum {{name.pascalCase()}}DataSourceTypes {
  /// [api] is the remote data source.
  api,

  /// [local] is the local data source.
  local,

  /// [assets] is the assets data source.
  assets,

  /// [firestore] is the firestore data source.
  firestore,

  /// [secure] is the secure data source.
  secure,

  /// [dummy] is the dummy data source.
  dummy;
}

/// [{{name.pascalCase()}}DataRepository] is a class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
class {{name.pascalCase()}}DataRepository {
  /// [getAll{{name.pascalCase()}}Models] returns a list of [{{name.pascalCase()}}Model]s.
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}Models({required {{name.pascalCase()}}DataSourceTypes source}) async {
    return _dataSourceByType(source).getAll();    
  }

  /// [get{{name.pascalCase()}}Model] returns a single [{{name.pascalCase()}}Model].
  Future<{{name.pascalCase()}}Model?> get{{name.pascalCase()}}Model(
      {required {{name.pascalCase()}}DataSourceTypes source, required String id}) async {
    return _dataSourceByType(source).get(id);
  }

  /// [addAll{{name.pascalCase()}}Models] adds all [{{name.pascalCase()}}Model]s to the data source.
  Future<void> addAll{{name.pascalCase()}}Models({required {{name.pascalCase()}}DataSourceTypes source, required List<{{name.pascalCase()}}Model> {{name.camelCase()}}Models}) async {
    return _dataSourceByType(source).addAll({{name.camelCase()}}Models);
  }

  /// [addit{{name.pascalCase()}}Model] addits a single [{{name.pascalCase()}}Model] to the data source.
  Future<void> addit{{name.pascalCase()}}Model({required {{name.pascalCase()}}DataSourceTypes source, required {{name.pascalCase()}}Model {{name.camelCase()}}Model}) async {
    return _dataSourceByType(source).update({{name.camelCase()}}Model.id, {{name.camelCase()}}Model);
  }

  /// [delete{{name.pascalCase()}}Model] deletes a single [{{name.pascalCase()}}Model] from the data source.
  Future<void> delete{{name.pascalCase()}}Model({required {{name.pascalCase()}}DataSourceTypes source, required String id}) async {
    return _dataSourceByType(source).delete(id);
  }

  /// [_dataSourceByType] returns the appropriate [{{name.pascalCase()}}DataSource] based on the [{{name.pascalCase()}}DataSourceTypes] enum.
  /// Defaults to [Local{{name.pascalCase()}}DataSource].
  /// This can be in local, an api, or firestore.
  {{name.pascalCase()}}DataSource _dataSourceByType({{name.pascalCase()}}DataSourceTypes type) {
    switch (type) {
      case {{name.pascalCase()}}DataSourceTypes.api:
        return Api{{name.pascalCase()}}DataSource();
      case {{name.pascalCase()}}DataSourceTypes.secure:
        return Secure{{name.pascalCase()}}DataSource();
      case {{name.pascalCase()}}DataSourceTypes.firestore:
        return Firestore{{name.pascalCase()}}DataSource();

      //TODO: set default accordingly
      default:
        return Dummy{{name.pascalCase()}}DataSource();
    }
  }
}
