import 'package:utilities/data_sources/paginated.dart';

import '/data/models/{{name.snakeCase()}}_model.dart';
import '/data/repositories/_repositories.dart';
import '/data/repositories/{{name.snakeCase()}}.repository.dart';
import '/data/sources/{{name.snakeCase()}}/_source.dart';

/// [{{name.pascalCase()}}Repository] is a class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
class {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}DataRepository _{{name.camelCase()}}DataRepository = DataRepositories.instance.{{name.camelCase()}};

  /// [{{name.pascalCase()}}Repository] constructor.
  {{name.pascalCase()}}Repository();

  //* {{name.pascalCase()}}Model Data Source Type
  final _source = Dummy{{name.pascalCase()}}DataSource();

  ResponseModel? _lastResponse;

  /// [getAll{{name.pascalCase()}}Models] fetches all [{{name.pascalCase()}}Model]s from the data source.
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}Models() {
    return _{{name.camelCase()}}DataRepository.getAll{{name.pascalCase()}}Models(source: _source);
  }

  /// [getPaged{{name.pascalCase()}}Models] fetches a page of [{{name.pascalCase()}}Model]s from the data source.
  Future<List<{{name.pascalCase()}}Model?>> getPaged{{name.pascalCase()}}Models({
    int? limit,
    bool refresh = false,
  }) async {
    final _response = await _{{name.camelCase()}}DataRepository.getPaged{{name.pascalCase()}}Models(
      source: _source,
      limit: limit,
      lastResponse: refresh ? null : _lastResponse,
    );
    _lastResponse = _response.first;
    return _response.second;
  }

  /// [get{{name.pascalCase()}}Model] fetches a single [{{name.pascalCase()}}Model] from the data source.
  Future<{{name.pascalCase()}}Model?> get{{name.pascalCase()}}Model(String id) {
    return _{{name.camelCase()}}DataRepository.get{{name.pascalCase()}}Model(
      source: _source,
      id: id,
    );
  }

  /// [addit{{name.pascalCase()}}Model] addits a single [{{name.pascalCase()}}Model] to the data source.
  Future<void> addit{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}Model) {
    return _{{name.camelCase()}}DataRepository.addit{{name.pascalCase()}}Model(
      source: _source,
      {{name.camelCase()}}Model: {{name.camelCase()}}Model,
    );
  }

  /// [addAll{{name.pascalCase()}}Models] adds all [{{name.pascalCase()}}Model]s to the data source.
  Future<void> addAll{{name.pascalCase()}}Models(List<{{name.pascalCase()}}Model> {{name.camelCase()}}Models) {
    return _{{name.camelCase()}}DataRepository.addAll{{name.pascalCase()}}Models(
      source: _source,
      {{name.camelCase()}}Models: {{name.camelCase()}}Models,
    );
  }

  /// [delete{{name.pascalCase()}}Model] deletes a single [{{name.pascalCase()}}Model] from the data source.
  Future<void> delete{{name.pascalCase()}}Model(String id) {
    return _{{name.camelCase()}}DataRepository.delete{{name.pascalCase()}}Model(
      source: _source,
      id: id,
    );
  }
}
