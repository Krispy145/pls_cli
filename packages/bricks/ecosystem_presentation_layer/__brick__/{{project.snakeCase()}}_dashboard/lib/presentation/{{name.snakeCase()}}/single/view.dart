import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:{{project.snakeCase()}}_dashboard/presentation/{{name.snakeCase()}}/single/store.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:{{project.snakeCase()}}_package/presentation/{{name.snakeCase()}}/form/store.dart";
import "package:{{project.snakeCase()}}_package/presentation/{{name.snakeCase()}}/form/view.dart";
import "package:theme/extensions/build_context.dart";
import "package:utilities/widgets/load_state/builder.dart";

/// [{{name.pascalCase()}}View] of the app.
@RoutePage()
class {{name.pascalCase()}}View extends StatelessWidget {
  final String? id;
  final {{name.pascalCase()}}Model? {{name.camelCase()}}Model;

  /// [{{name.pascalCase()}}View] constructor.
  {{name.pascalCase()}}View({super.key, this.id, this.{{name.camelCase()}}Model}) {
    store = Addit{{name.pascalCase()}}Store(id: id, initial{{name.pascalCase()}}Model: {{name.camelCase()}}Model);
  }

  /// [store] is an instance of [Addit{{name.pascalCase()}}Store], used in the [LoadStateBuilder].
  /// initialized in the constructor.
  late final Addit{{name.pascalCase()}}Store store;
  late final {{name.camelCase()}}FormStore = {{name.pascalCase()}}FormStore(
    {{name.camelCase()}}Store: store,
    {{name.camelCase()}}Model: store.current{{name.pascalCase()}},
    onValueSaved: store.addit{{name.pascalCase()}}Model,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          store.isEmpty ? "{{name.pascalCase()}} Creation" : "Update ${store.current{{name.pascalCase()}}?.name}",
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: {{name.pascalCase()}}FormView(
              store: {{name.camelCase()}}FormStore,
            ),
          );
        },
      ),
    );
  }
}
