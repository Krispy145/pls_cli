

import "package:mobx/mobx.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:{{project.snakeCase()}}_package/presentation/{{name.snakeCase()}}/single_store.dart";
import "package:utilities/data/sources/source.dart";

part "store.g.dart";

/// [Addit{{name.pascalCase()}}Store] is a class that uses [_Addit{{name.pascalCase()}}Store] to manage state of the {{name.camelCase()}}s feature.
class Addit{{name.pascalCase()}}Store = _Addit{{name.pascalCase()}}Store with _$Addit{{name.pascalCase()}}Store;

/// [_Addit{{name.pascalCase()}}Store] is a class that manages the state of the {{name.camelCase()}}s feature.
abstract class _Addit{{name.pascalCase()}}Store extends {{name.pascalCase()}}Store with Store {
  /// [_Addit{{name.pascalCase()}}Store] constructor.
  _Addit{{name.pascalCase()}}Store({
    super.id,
    super.initial{{name.pascalCase()}}Model,
  });

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
}

