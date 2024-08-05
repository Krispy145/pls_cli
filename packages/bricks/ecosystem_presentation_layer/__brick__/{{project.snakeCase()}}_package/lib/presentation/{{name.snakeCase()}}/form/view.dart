import "package:flutter/material.dart" hide ProgressIndicator;
import "package:flutter/material.dart";
import "package:forms/presentation/models/reactive_view.dart";
import "package:reactive_dropdown_search/reactive_dropdown_search.dart";
import "package:reactive_forms/reactive_forms.dart";
import "package:thrift_findr_package/data/models/{{name.snakeCase()}}_category_model.dart";
import "package:thrift_findr_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:utilities/sizes/spacers.dart";

import "store.dart";

class {{name.pascalCase()}}FormView extends ReactiveFormsModelView<{{name.pascalCase()}}Model, {{name.pascalCase()}}FormStore> {
  const {{name.pascalCase()}}FormView({super.key, required super.store, required super.onBack});

  @override
  Widget formBuilder(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              /// FORM FIELDS
              /// 
              
              /// NAME
              ReactiveTextField<String>(
                formControlName: store.nameKey,
                decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
              ),
              Sizes.m.spacer(),              
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReactiveFormConsumer(
                builder: (context, form, w) {
                  return Visibility(
                    visible: form.valid,
                    child: FilledButton(
                      onPressed: () => store.submitPressed().then((value) => Navigator.of(context).pop(value)),
                      child: Text(store.isAdding ? "Create {{name.pascalCase()}}" : "Update {{name.pascalCase()}}"),
                    ),
                  );
                },
              ),
              Sizes.l.spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
