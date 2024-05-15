// ignore_for_file: unused_element

import "package:mobx/mobx.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:{{project.snakeCase()}}_package/presentation/{{name.snakeCase()}}/single_store.dart";

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
  Future<void> addit{{name.pascalCase()}}Model({{name.pascalCase()}}Model {{name.camelCase()}}Model) async {
    await repository.addit{{name.pascalCase()}}Model(current{{name.pascalCase()}} ?? {{name.camelCase()}}Model);
  }
}
