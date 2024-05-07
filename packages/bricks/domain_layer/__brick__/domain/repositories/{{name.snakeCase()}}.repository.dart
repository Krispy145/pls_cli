import '/data/models/{{name.snakeCase()}}_model.dart';
import '/data/repositories/_repositories.dart';
import '/data/repositories/{{name.snakeCase()}}.repository.dart';



/// [{{name.pascalCase()}}Repository] is an abstract class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
class {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}DataRepository _{{name.camelCase()}}DataRepository = DataRepositories.instance.{{name.camelCase()}};

  /// [{{name.pascalCase()}}Repository] constructor.
  {{name.pascalCase()}}Repository();

  //* {{name.pascalCase()}}Model Data Source Type
  final _source = DataSourceTypes.dummy;

  /// [getAll{{name.pascalCase()}}Models] fetches all [{{name.pascalCase()}}Model]s from the data source.
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}Models() {
    return _{{name.camelCase()}}DataRepository.getAll{{name.pascalCase()}}Models(source: _source);
  }

  /// [get{{name.pascalCase()}}Model] fetches a single [{{name.pascalCase()}}Model] from the data source.
  Future<{{name.pascalCase()}}Model?> get{{name.pascalCase()}}Model(String id) {
    return _{{name.camelCase()}}DataRepository.get{{name.pascalCase()}}Model(
      source: _source,
      id: id,
    );
  }

  /// [addAll{{name.pascalCase()}}Models] adds all [{{name.pascalCase()}}Model]s to the data source.
  Future<void> addAll{{name.pascalCase()}}Models(List<{{name.pascalCase()}}Model> {{name.camelCase()}}Models) {
    return _{{name.camelCase()}}DataRepository.addAll{{name.pascalCase()}}Models(
      source: _source,
      {{name.camelCase()}}Models: {{name.camelCase()}}Models,
    );
  }
}
