import "package:flutter/material.dart";
import "package:forms/presentation/components/base/form_field.dart";
import "package:forms/presentation/components/text/form_field.dart";
import "package:forms/presentation/models/view.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";

import "store.dart";

class {{name.pascalCase()}}FormView extends FormsModelView<{{name.pascalCase()}}Model, {{name.pascalCase()}}FormStore> {
  const {{name.pascalCase()}}FormView({super.key, required super.store});

  @override
  Map<String, BaseFormField> modelFields(BuildContext context) {
    return {
      "name": DOTextFormField(store: store.nameStore),
    };
  }

  @override
  List<Widget>? stackedWidgets(BuildContext context) => null;
}
