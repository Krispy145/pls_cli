import "dart:async";

import "package:forms/presentation/models/reactive_store.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:mobx/mobx.dart";
import "package:reactive_forms/reactive_forms.dart";

part "store.g.dart";

/// [{{name.pascalCase()}}FormStore] is a class that uses [_{{name.pascalCase()}}FormStore] to manage state of the  feature.
class {{name.pascalCase()}}FormStore = _{{name.pascalCase()}}FormStore with _${{name.pascalCase()}}FormStore;

/// [_{{name.pascalCase()}}FormStore] is a class that manages the state of the  feature.
abstract class _{{name.pascalCase()}}FormStore extends ReactiveFormsModelStore<{{name.pascalCase()}}Model> with Store {
  final bool isCurrent{{name.pascalCase()}};

  _{{name.pascalCase()}}FormStore({
    required {{name.pascalCase()}}Model? {{name.camelCase()}}Model,
    required this.isCurrent{{name.pascalCase()}},
    required super.saveValue,
  }) : super(editingValue: {{name.camelCase()}}Model) {
    setLoaded();
  }

  final idKey = "id";

  @override
  late FormGroup form = FormGroup(
    {
      idKey: FormControl<String>(
        value: editingValue?.id ?? "",
      ),
    },
    disabled: !isCurrent{{name.pascalCase()}},
  );

  @override
  FutureOr<{{name.pascalCase()}}Model?> prepareValueFromForm() {
    final savedValue = editingValue!.copyWith();
    return savedValue;
  }
}
