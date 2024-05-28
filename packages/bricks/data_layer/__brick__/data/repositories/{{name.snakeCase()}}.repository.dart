import 'package:utilities/data/sources/paginated.dart';
import 'package:utilities/helpers/tuples.dart';

import '/data/models/{{name.snakeCase()}}_model.dart';
import '/data/sources/{{name.snakeCase()}}/_source.dart';

/// [{{name.pascalCase()}}DataRepository] is a class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
class {{name.pascalCase()}}DataRepository {
  /// [getAll{{name.pascalCase()}}Models] returns a list of [{{name.pascalCase()}}Model]s.
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}Models({required {{name.pascalCase()}}DataSource source}) async {
    return source.getAll();
  }

  /// [getPaged{{name.pascalCase()}}Models] returns a page of [{{name.pascalCase()}}Model]s.
  Future<Pair<ResponseModel, List<{{name.pascalCase()}}Model?>>> getPaged{{name.pascalCase()}}Models({
    required {{name.pascalCase()}}DataSource source,
    int? limit,
    ResponseModel? lastResponse,
  }) async {
    return source.getPage(size: limit, lastResponse: lastResponse);
  }

  /// [get{{name.pascalCase()}}Model] returns a single [{{name.pascalCase()}}Model].
  Future<{{name.pascalCase()}}Model?> get{{name.pascalCase()}}Model({required {{name.pascalCase()}}DataSource source, required String id}) async {
    return source.get(id);
  }

  /// [addAll{{name.pascalCase()}}Models] adds all [{{name.pascalCase()}}Model]s to the data source.
  Future<void> addAll{{name.pascalCase()}}Models({required {{name.pascalCase()}}DataSource source, required List<{{name.pascalCase()}}Model> {{name.camelCase()}}Models}) async {
    return source.addAll({{name.camelCase()}}Models);
  }

  /// [addit{{name.pascalCase()}}Model] addits a single [{{name.pascalCase()}}Model] to the data source.
  Future<void> addit{{name.pascalCase()}}Model({required {{name.pascalCase()}}DataSource source, required {{name.pascalCase()}}Model {{name.camelCase()}}Model}) async {
    return source.update({{name.camelCase()}}Model.id, {{name.camelCase()}}Model);
  }

  /// [delete{{name.pascalCase()}}Model] deletes a single [{{name.pascalCase()}}Model] from the data source.
  Future<void> delete{{name.pascalCase()}}Model({required {{name.pascalCase()}}DataSource source, required String id}) async {
    return source.delete(id);
  }
}
