import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:{{project.snakeCase()}}/navigation/routes.gr.dart";
import "package:{{project.snakeCase()}}/data/models/{{name.snakeCase()}}_model.dart";
import "package:theme/extensions/build_context.dart";
import "package:utilities/layouts/paginated_list/builder.dart";
import "package:utilities/sizes/spacers.dart";
import "package:utilities/widgets/load_state/builder.dart";

import "store.dart";

/// [{{name.pascalCase()}}sView] of the app.
@RoutePage()
class {{name.pascalCase()}}sView extends StatelessWidget {
  /// [{{name.pascalCase()}}sView] constructor.
  {{name.pascalCase()}}sView({super.key});

  /// [store] is an instance of [{{name.pascalCase()}}sStore], used in the [PackageLoadStateBuilder].
  /// TODO: Move to Managers if requiring global state of store.
  final {{name.pascalCase()}}sStore store = {{name.pascalCase()}}sStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("{{project.titleCase()}}s"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.navigateTo({{name.pascalCase()}}Route()),
        child: const Icon(Icons.add),
      ),
      body: PaginatedListBuilder<{{name.pascalCase()}}Model,String>.listView(
        store: store,
        itemBuilder: (context, index, {{name.camelCase()}}sModel) {          
          return Dismissible(
            key: Key({{name.camelCase()}}sModel.id),
            onDismissed: (direction) => store.delete{{name.pascalCase()}}Model({{name.camelCase()}}sModel.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: context.colorScheme.error,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete, color: context.colorScheme.onError),
                  Sizes.l.spacer(axis: Axis.horizontal),
                ],
              ),
            ),
            child: ListTile(
              title: Text({{name.camelCase()}}sModel.id),
              subtitle: Text({{name.camelCase()}}sModel.name ?? ""),
              onTap: () => context.navigateTo(
                {{name.pascalCase()}}Route(
                  id: {{name.camelCase()}}sModel.id,
                  {{name.camelCase()}}Model: {{name.camelCase()}}sModel,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

