// ignore_for_file: unused_element

import "package:forms/presentation/components/text/store.dart";
import "package:forms/presentation/models/store.dart";
import "package:mobx/mobx.dart";
import "package:{{project.snakeCase()}}_package/presentation/{{name.snakeCase()}}/single_store.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";

part "store.g.dart";

/// [{{name.pascalCase()}}FormStore] is a class that uses [_{{name.pascalCase()}}FormStore] to manage state of the {{name.camelCase()}}s feature.
class {{name.pascalCase()}}FormStore = _{{name.pascalCase()}}FormStore with _${{name.pascalCase()}}FormStore;

/// [_{{name.pascalCase()}}FormStore] is a class that manages the state of the {{name.camelCase()}}s feature.
abstract class _{{name.pascalCase()}}FormStore extends FormsModelStore<{{name.pascalCase()}}Model> with Store {
  final {{name.pascalCase()}}Store {{name.camelCase()}}Store;

  _{{name.pascalCase()}}FormStore({
    required this.{{name.camelCase()}}Store,
    required {{name.pascalCase()}}Model? {{name.camelCase()}}Model,
    required super.onValueSaved,
  }) : super(value: {{name.camelCase()}}Model ?? {{name.pascalCase()}}Model.empty, isAdding: {{name.camelCase()}}Model == null);

  late final nameStore = TextFormFieldStore(
    value: value.name,
    onValueChanged: (newValue) {
      onValueChanged(
        value.copyWith(name: newValue),
      );
    },
    title: "Name",
  );
}
