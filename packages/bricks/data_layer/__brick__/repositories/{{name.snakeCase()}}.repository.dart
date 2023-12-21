import '/data/repositories/_repositories.dart';

import '/data/models/{{name.snakeCase()}}_model.dart';
import '/data/sources/{{name.snakeCase()}}/_source.dart';
import '/data/sources/{{name.snakeCase()}}/api.source.dart';
import '/data/sources/{{name.snakeCase()}}/firestore.source.dart';
import '/data/sources/{{name.snakeCase()}}/local.source.dart';

/// [{{name.pascalCase()}}DataRepository] is a class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
class {{name.pascalCase()}}DataRepository {
  /// [getAll{{name.pascalCase()}}Models] returns a list of [{{name.pascalCase()}}Model]s.
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}Models({required SourceTypes source}) async {
    return _dataSourceByType(source).getAll();    
  }

  /// [addAll{{name.pascalCase()}}Models] adds all [{{name.pascalCase()}}Model]s to the data source.
  Future<void> addAll{{name.pascalCase()}}Models({required SourceTypes source, required List<{{name.pascalCase()}}Model> {{name.camelCase()}}Models}) async {
    return _dataSourceByType(source).addAll({{name.camelCase()}}Models);
  }

  /// [_dataSourceByType] returns the appropriate [{{name.pascalCase()}}DataSource] based on the [SourceTypes] enum.
  /// Defaults to [Local{{name.pascalCase()}}DataSource].
  /// This can be in local, an api, or firestore.
  {{name.pascalCase()}}DataSource _dataSourceByType(SourceTypes type) {
    switch (type) {
      case SourceTypes.api:
        return Api{{name.pascalCase()}}DataSource();
      case SourceTypes.local:
        return Local{{name.pascalCase()}}DataSource();
      case SourceTypes.firestore:
        return Firestore{{name.pascalCase()}}DataSource();

      //TODO: set default accordingly
      default:
        return Local{{name.pascalCase()}}DataSource();
    }
  }
}
