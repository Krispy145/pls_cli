// ignore_for_file: overridden_fields

import "dart:async";

import "package:forms/presentation/models/reactive_store.dart";
import "package:{{project.snakeCase()}}/data/models/{{name.snakeCase()}}_model.dart";
import "package:mobx/mobx.dart";
import "package:reactive_forms/reactive_forms.dart";

part "store.g.dart";

/// [{{name.pascalCase()}}FormStore] is a class that uses [_{{name.pascalCase()}}FormStore] to manage state of the  feature.
class {{name.pascalCase()}}FormStore = _{{name.pascalCase()}}FormStore with _${{name.pascalCase()}}FormStore;

/// [_{{name.pascalCase()}}FormStore] is a class that manages the state of the  feature.
abstract class _{{name.pascalCase()}}FormStore extends ReactiveFormsModelStore<{{name.pascalCase()}}Model> with Store {

  _{{name.pascalCase()}}FormStore({
    required {{name.pascalCase()}}Model? {{name.camelCase()}}Model,
    required super.saveValue,
  }) : super(editingValue: {{name.camelCase()}}Model);

  final idKey = "id";

@override
Future<void> initialize() async {
    setLoading();
    form = FormGroup(
      {
        idKey: FormControl<String>(
          value: editingValue?.id ?? "",
        ),       
      },
    );
    await super.initialize();
  }

  
  @override
  FutureOr<{{name.pascalCase()}}Model?> prepareValueFromForm() {
    final value = form.value;
    final map = {{name.pascalCase()}}Model.fromMap(value);
    return map;
  }
}

