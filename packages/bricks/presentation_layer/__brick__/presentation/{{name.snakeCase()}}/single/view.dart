import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:{{project.snakeCase()}}_package/presentation/{{name.snakeCase()}}/list_store.dart";
import "package:{{project.snakeCase()}}_package/presentation/{{name.snakeCase()}}/single_store.dart";
import "package:utilities/widgets/load_state/builder.dart";

/// [{{name.pascalCase()}}View] of the app.
@RoutePage()
class {{name.pascalCase()}}View extends StatelessWidget {
  final String? id;
  final {{name.pascalCase()}}Model? {{name.camelCase()}}Model;

  /// [{{name.pascalCase()}}View] constructor.
  {{name.pascalCase()}}View({super.key, this.id, this.{{name.camelCase()}}Model})
      : assert(id != null || {{name.camelCase()}}Model != null, "id or {{name.camelCase()}}Model must be provided."),
        store = {{name.pascalCase()}}Store(id: id, initial{{name.pascalCase()}}Model: {{name.camelCase()}}Model);

  /// [store] is an instance of [{{name.pascalCase()}}sStore], used in the [LoadStateBuilder].
  /// initialized in the constructor.
  final {{name.pascalCase()}}Store store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadStateBuilder(
        viewStore: store,
        errorBuilder: (context) => Center(
          child: Text("Error loading {{name.camelCase()}}: $id / ${{name.camelCase()}}Model."),
        ),
        loadedBuilder: (context) => Column(
          children: [
            Text(store.current{{name.pascalCase()}}!.id),
          ],
        ),
      ),
    );
  }
}