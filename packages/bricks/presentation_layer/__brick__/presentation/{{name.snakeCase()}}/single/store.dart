

import "package:{{project.snakeCase()}}/data/models/{{name.snakeCase()}}_model.dart";
import "package:utilities/data/sources/source.dart";
import "package:mobx/mobx.dart";

import "../list/store.dart";

part "store.g.dart";

/// [{{name.pascalCase()}}Store] is a class that uses [_{{name.pascalCase()}}Store] to manage state of the {{name.camelCase()}}s feature.
class {{name.pascalCase()}}Store = _{{name.pascalCase()}}Store with _${{name.pascalCase()}}Store;

/// [_{{name.pascalCase()}}Store] is a class that manages the state of the {{name.camelCase()}}s feature.
abstract class _{{name.pascalCase()}}Store extends {{name.pascalCase()}}sStore with Store {
  final String? id;

  /// [_{{name.pascalCase()}}Store] constructor.
  _{{name.pascalCase()}}Store({
    this.id,
    {{name.pascalCase()}}Model? initial{{name.pascalCase()}}Model,
  }) {
    _load{{name.pascalCase()}}(initial{{name.pascalCase()}}Model);
  }

  /// [current{{name.pascalCase()}}] is an observable list of [{{name.pascalCase()}}Model]s.
  @observable
  {{name.pascalCase()}}Model? current{{name.pascalCase()}};


  /// [addit{{name.pascalCase()}}Model] addits a [{{name.pascalCase()}}Model] to the data source.
  @action
  Future<RequestResponse> addit{{name.pascalCase()}}Model(bool isAdding, {{name.pascalCase()}}Model {{name.camelCase()}}Model) async {
    if (isAdding) {
      final result = await repository.add{{name.pascalCase()}}Model({{name.camelCase()}}Model);
      return result.first;
    } else {
      return repository.update{{name.pascalCase()}}Model({{name.camelCase()}}Model);
    }
  }

  void _load{{name.pascalCase()}}({{name.pascalCase()}}Model? initial{{name.pascalCase()}}Model) {
    if (initial{{name.pascalCase()}}Model == null && id != null) {
      setLoading();
      repository.get{{name.pascalCase()}}Model(id!).then((value) {
        current{{name.pascalCase()}} = value.second;
      });
    } else {
      current{{name.pascalCase()}} = initial{{name.pascalCase()}}Model;
    }
    if (current{{name.pascalCase()}} != null) {
      setLoaded();
    } else {
      setEmpty("No {{name.camelCase()}} found.");
    }
  }
}

