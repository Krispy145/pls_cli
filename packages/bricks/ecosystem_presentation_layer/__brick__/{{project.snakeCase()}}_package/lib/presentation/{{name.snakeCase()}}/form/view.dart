import "package:flutter/material.dart";
import "package:forms/presentation/components/buttons/submit_button.dart";
import "package:forms/presentation/models/reactive_view.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:utilities/sizes/spacers.dart";

import "store.dart";

class {{name.pascalCase()}}FormView extends ReactiveFormsModelView<{{name.pascalCase()}}Model, {{name.pascalCase()}}FormStore> {
  const {{name.pascalCase()}}FormView({
    super.key,
    required super.store,
    required super.onBack,
  }) ;

  @override
  Widget formBuilder(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              // TEXT

              Sizes.m.spacer(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReactiveFormSubmitButton(store: store, buttonText: store.isAdding ? "Create {{name.pascalCase()}}" : "Update {{name.pascalCase()}}", onBack: onBack),
              Sizes.l.spacer(),
            ],
          ),
        ),
        Sizes.l.spacer(),
      ],
    );
  }
}

