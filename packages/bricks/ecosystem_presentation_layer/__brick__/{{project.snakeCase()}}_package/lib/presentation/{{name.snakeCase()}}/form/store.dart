// ignore_for_file: unused_element

import "dart:async";

import "package:forms/presentation/models/reactive_store.dart";
import "package:mobx/mobx.dart";
import "package:reactive_forms/reactive_forms.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_category_model.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:{{project.snakeCase()}}_package/domain/repositories/{{name.snakeCase()}}_category.repository.dart";
import "package:utilities/data/models/basic_search_query_model.dart";

part "store.g.dart";

/// [{{name.pascalCase()}}FormStore] is a class that uses [_{{name.pascalCase()}}FormStore] to manage state of the ministries feature.
class {{name.pascalCase()}}FormStore = _{{name.pascalCase()}}FormStore with _${{name.pascalCase()}}FormStore;

/// [_{{name.pascalCase()}}FormStore] is a class that manages the state of the ministries feature.
abstract class _{{name.pascalCase()}}FormStore extends ReactiveFormsModelStore<{{name.pascalCase()}}Model> with Store {
  _{{name.pascalCase()}}FormStore({
    required {{name.pascalCase()}}Model? {{name.camelCase()}}Model,
    required super.saveValue,
  }) : super(editingValue: {{name.camelCase()}}Model) {   
      setLoaded();    
  }


  final idKey = "id";
  final nameKey = "name";

  @override
  late FormGroup form = FormGroup(
    {
      idKey: FormControl<String>(
        value: editingValue?.id ?? "",
      ),
      nameKey: FormControl<String>(
        value: editingValue?.name,
        validators: [Validators.required],
      ),     
    },
  );

  @override
  FutureOr<{{name.pascalCase()}}Model?> prepareValueFromForm() {    
    // return event
    return {{name.pascalCase()}}Model.fromMap(form.value);
  }
}
