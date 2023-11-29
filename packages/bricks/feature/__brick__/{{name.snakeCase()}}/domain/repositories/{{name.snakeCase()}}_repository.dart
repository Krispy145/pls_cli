import '../models/{{name.snakeCase()}}_model.dart';

/// [{{name.pascalCase()}}Repository] is an abstract class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
abstract class {{name.pascalCase()}}Repository {
  /// [{{name.pascalCase()}}Repository] constructor.
  {{name.pascalCase()}}Repository();

  /// [getAll{{name.pascalCase()}}Models] fetches all [{{name.pascalCase()}}Model]s from the data source.
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}Models();
}
