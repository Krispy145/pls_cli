import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:{{project.snakeCase()}}_app/navigation/routes.gr.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";
import "package:{{project.snakeCase()}}_package/presentation/{{name.snakeCase()}}/list_store.dart";
import "package:utilities/layouts/paginated_list/builder.dart";
import "package:utilities/widgets/load_state/builder.dart";

/// [{{name.pascalCase()}}sView] of the app.
@RoutePage()
class {{name.pascalCase()}}sView extends StatelessWidget {
  /// [{{name.pascalCase()}}sView] constructor.
  {{name.pascalCase()}}sView({super.key});

  /// [store] is an instance of [{{name.pascalCase()}}sStore], used in the [LoadStateBuilder].
  final {{name.pascalCase()}}sStore store = {{name.pascalCase()}}sStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginatedListBuilder<{{name.pascalCase()}}Model>.listView(
        store: store,
        itemBuilder: (context, index, {{name.camelCase()}}Model) {
          return ListTile(
            title: Text({{name.camelCase()}}Model.id),
            onTap: () => context.navigateTo(
              {{name.pascalCase()}}Route(id: {{name.camelCase()}}Model.id, {{name.camelCase()}}Model: {{name.camelCase()}}Model),
            ),
          );
        },
      ),
    );
  }
}

