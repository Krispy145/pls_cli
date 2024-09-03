import "/data/models/{{name.snakeCase()}}_model.dart";
import "/data/repositories/_repositories.dart";
import "/data/repositories/{{name.snakeCase()}}.repository.dart";
import "/data/sources/{{name.snakeCase()}}/_source.dart";
import "package:utilities/data/models/basic_search_query_model.dart";
import "package:utilities/data/sources/paginated.dart";
import "package:utilities/data/sources/source.dart";
import "package:utilities/helpers/tuples.dart";

/// [{{name.pascalCase()}}Repository] is an abstract class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
class {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}DataRepository _{{name.camelCase()}}DataRepository = DataRepositories.instance.{{name.camelCase()}};

  /// [{{name.pascalCase()}}Repository] constructor.
  {{name.pascalCase()}}Repository();

  //* {{name.pascalCase()}}Model Data Source Type
  final _source = Firestore{{name.pascalCase()}}DataSource();

  ResponseModel? _lastResponse;

  /// [getAll{{name.pascalCase()}}Models] fetches all [{{name.pascalCase()}}Model]s from the data source.
  Future<Pair<RequestResponse, List<{{name.pascalCase()}}Model?>>> getAll{{name.pascalCase()}}Models() {
    return _{{name.camelCase()}}DataRepository.getAll{{name.pascalCase()}}Models(source: _source);
  }

  /// [getPaged{{name.pascalCase()}}Models] fetches a page of [{{name.pascalCase()}}Model]s from the data source.
  Future<Pair<RequestResponse, List<{{name.pascalCase()}}Model?>>> getPaged{{name.pascalCase()}}Models({
    int? limit,
    bool refresh = false,
  }) async {
    final _response = await _{{name.camelCase()}}DataRepository.getPaged{{name.pascalCase()}}Models(
      source: _source,
      limit: limit,
      lastResponse: refresh ? null : _lastResponse,
    );
    _lastResponse = _response.second.first;
    final _{{name.camelCase()}}s = _response.second.second;
    return Pair(_response.first, _{{name.camelCase()}}s);
  }

  /// [get{{name.pascalCase()}}Model] fetches a [{{name.pascalCase()}}Model] from the data source.
  Future<Pair<RequestResponse, {{name.pascalCase()}}Model?>> get{{name.pascalCase()}}Model(String id) {
    return _{{name.camelCase()}}DataRepository.get{{name.pascalCase()}}Model(source: _source, id: id);
  }

  /// [addAll{{name.pascalCase()}}Models] adds all [{{name.pascalCase()}}Model]s to the data source.
  Future<RequestResponse> addAll{{name.pascalCase()}}Models(List<{{name.pascalCase()}}Model> {{name.camelCase()}}Models) {
    return _{{name.camelCase()}}DataRepository.addAll{{name.pascalCase()}}Models(
      source: _source,
      {{name.camelCase()}}Models: {{name.camelCase()}}Models,
    );
  }

  /// [add{{name.pascalCase()}}Model] adds a [{{name.pascalCase()}}Model] to the data source.
  Future<Pair<RequestResponse, {{name.pascalCase()}}Model?>> add{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}Model) {
    return _{{name.camelCase()}}DataRepository.add{{name.pascalCase()}}Model(
      source: _source,
      {{name.camelCase()}}Model: {{name.camelCase()}}Model,
    );
  }

  /// [update{{name.pascalCase()}}Model] adds a [{{name.pascalCase()}}Model] to the data source.
  Future<RequestResponse> update{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}Model) {
    return _{{name.camelCase()}}DataRepository.update{{name.pascalCase()}}Model(
      source: _source,
      {{name.camelCase()}}Model: {{name.camelCase()}}Model,
    );
  }

  /// [delete{{name.pascalCase()}}Model] deletes a [{{name.pascalCase()}}Model] from the data source.
  Future<RequestResponse> delete{{name.pascalCase()}}Model(String id) {
    return _{{name.camelCase()}}DataRepository.delete{{name.pascalCase()}}Model(source: _source, id: id);
  }

  /// [search{{name.pascalCase()}}Models] searches for [{{name.pascalCase()}}Model]s from the data source.
  Future<Pair<RequestResponse, List<{{name.pascalCase()}}Model?>>> search{{name.pascalCase()}}Models(BasicSearchQueryModel query) {
    return _{{name.camelCase()}}DataRepository.search{{name.pascalCase()}}Models(
      source: _source,
      searchQuery: query,
    );
  }

  /// [searchPaged{{name.pascalCase()}}Models] fetches a page of [{{name.pascalCase()}}Model]s from the data source.
  Future<Pair<RequestResponse, List<{{name.pascalCase()}}Model?>>> searchPaged{{name.pascalCase()}}Models({
    int? limit,
    bool refresh = false,
    required BasicSearchQueryModel filter,
  }) async {
    final _response = await _{{name.camelCase()}}DataRepository.searchPaged{{name.pascalCase()}}Models(
      source: _source,
      query: filter,
      limit: limit,
      lastResponse: refresh ? null : _lastResponse,
    );
    _lastResponse = _response.second.first;
    final _{{name.camelCase()}}s = _response.second.second;
    return Pair(_response.first, _{{name.camelCase()}}s);
  }
}
