import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:{{project.snakeCase()}}/presentation/{{name.snakeCase()}}/single/store.dart";
import "package:{{project.snakeCase()}}/data/models/{{name.snakeCase()}}_model.dart";
import "package:{{project.snakeCase()}}/presentation/{{name.snakeCase()}}/form/store.dart";
import "package:{{project.snakeCase()}}/presentation/{{name.snakeCase()}}/form/view.dart";
import "package:theme/extensions/build_context.dart";
import "package:utilities/widgets/load_state/builder.dart";

/// [{{name.pascalCase()}}View] of the app.
@RoutePage()
class {{name.pascalCase()}}View extends StatelessWidget {
  final String? id;
  final {{name.pascalCase()}}Model? {{name.camelCase()}}Model;

  /// [{{name.pascalCase()}}View] constructor.
  {{name.pascalCase()}}View({super.key, this.id, this.{{name.camelCase()}}Model}) {
    store = {{name.pascalCase()}}Store(id: id, initial{{name.pascalCase()}}Model: {{name.camelCase()}}Model);
  }

  /// [store] is an instance of [{{name.pascalCase()}}Store], used in the [LoadStateBuilder].
  /// initialized in the constructor.
  late final {{name.pascalCase()}}Store store;
  late final {{name.camelCase()}}FormStore = {{name.pascalCase()}}FormStore(
    {{name.camelCase()}}Model: store.current{{name.pascalCase()}},
    saveValue: store.addit{{name.pascalCase()}}Model,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          {{name.camelCase()}}FormStore.isAdding ? "{{name.pascalCase()}} Creation" : "Update ${store.current{{name.pascalCase()}}?.name}",
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: {{name.pascalCase()}}FormView(
              store: {{name.camelCase()}}FormStore,
              onBack: (response) => context.router.maybePop(response),
            ),
          );
        },
      ),
    );
  }
}
