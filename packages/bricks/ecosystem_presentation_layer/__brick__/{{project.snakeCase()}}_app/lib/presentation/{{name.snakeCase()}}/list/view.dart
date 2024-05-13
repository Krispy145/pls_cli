import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:{{project.snakeCase()}}_package/presentation/{{name.snakeCase()}}/list_store.dart";
import "package:utilities/widgets/load_state/builder.dart";

/// [{{name.pascalCase()}}sView] of the app.
@RoutePage()
class {{name.pascalCase()}}sView extends StatelessWidget {
  /// [{{name.pascalCase()}}sView] constructor.
  {{name.pascalCase()}}sView({super.key});

  /// [store] is an instance of [{{name.pascalCase()}}sStore], used in the [LoadStateBuilder].
  final {{name.pascalCase()}}sStore store = {{name.pascalCase()}}sStore()..load{{name.pascalCase()}}Models();

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: store,
      emptyBuilder: (context) => const Center(
        child: Text("Empty {{name.camelCase()}}s view."),
      ),
      loadedBuilder: (context) => ListView.builder(
        itemCount: store.{{name.camelCase()}}s.length,
        itemBuilder: (context, index) {
          final {{name.camelCase()}}Model = store.{{name.camelCase()}}s[index]!;
          return ListTile(title: Text({{name.camelCase()}}Model.id));
        },
      ),
      errorBuilder: (context) => const Center(
        child: Text("Error loading {{name.camelCase()}}s view."),
      ),
    );
  }
}
