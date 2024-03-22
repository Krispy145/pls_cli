import '/data/models/{{name.snakeCase()}}_model.dart';
import '/data/repositories/_repositories.dart';
import '/data/repositories/{{name.snakeCase()}}.repository.dart';

/// [{{name.pascalCase()}}Repository] is an abstract class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
class {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}DataRepository _{{name.camelCase()}}DataRepository = DataRepositories.instance.{{name.camelCase()}};

  /// [{{name.pascalCase()}}Repository] constructor.
  {{name.pascalCase()}}Repository();

  /// [getAll{{name.pascalCase()}}ModelsFromApi] fetches all [{{name.pascalCase()}}Model]s from the data source.
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}ModelsFromApi() {
    return _{{name.camelCase()}}DataRepository.getAll{{name.pascalCase()}}Models(source: DataSourceTypes.api);
  }

  /// [addAll{{name.pascalCase()}}ModelsFromApi] adds all [{{name.pascalCase()}}Model]s to the data source.
  Future<void> addAll{{name.pascalCase()}}ModelsFromApi(List<{{name.pascalCase()}}Model> {{name.camelCase()}}Models) {
    return _{{name.camelCase()}}DataRepository.addAll{{name.pascalCase()}}Models(source: DataSourceTypes.api, {{name.camelCase()}}Models: {{name.camelCase()}}Models);
  }
}
