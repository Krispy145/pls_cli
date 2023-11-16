import '../../domain/models/{{name.snakeCase()}}_model.dart';

/// [{{name.pascalCase()}}Repository] is an abstract class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
abstract class {{name.pascalCase()}}Repository {
  /// [getAll{{name.pascalCase()}}Models] fetches all [{{name.pascalCase()}}Model]s from the data source.
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}Models();

  /// [get{{name.pascalCase()}}ModelById] fetches a [{{name.pascalCase()}}Model] by its [id] from the data source.
  Future<{{name.pascalCase()}}Model?> get{{name.pascalCase()}}ModelById(String id);

  /// [add{{name.pascalCase()}}Model] adds a [{{name.pascalCase()}}Model] to the data source.
  Future<void> add{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}});

  /// [update{{name.pascalCase()}}Model] updates a [{{name.pascalCase()}}Model] in the data source.
  Future<void> update{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}});

  /// [delete{{name.pascalCase()}}Model] deletes a [{{name.pascalCase()}}Model] from the data source.
  Future<void> delete{{name.pascalCase()}}Model(String id);
}
