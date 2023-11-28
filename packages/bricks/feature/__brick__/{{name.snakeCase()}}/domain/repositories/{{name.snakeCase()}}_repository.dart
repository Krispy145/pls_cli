import '../../data/sources/{{name.snakeCase()}}_source.dart';
import '../../domain/models/{{name.snakeCase()}}_model.dart';

/// [{{name.pascalCase()}}Repository] is an abstract class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
class {{name.pascalCase()}}Repository {
  /// [dataSource] is an instance of [{{name.pascalCase()}}DataSource].
  final {{name.pascalCase()}}DataSource dataSource;

  /// [{{name.pascalCase()}}Repository] constructor.
  {{name.pascalCase()}}Repository(this.dataSource);

  /// [getAll{{name.pascalCase()}}Models] fetches all [{{name.pascalCase()}}Model]s from the data source.
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}Models() {
    return dataSource.getAll();
  }
}
