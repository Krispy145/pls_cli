import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:theme/extensions/build_context.dart";
import "package:{{project.snakeCase()}}_dashboard/dependencies/injection.dart";
import "package:{{project.snakeCase()}}_dashboard/navigation/routes.gr.dart";
import "package:utilities/sizes/spacers.dart";
import "package:utilities/widgets/load_state/builder.dart";
import "package:{{project.snakeCase()}}_package/data/models/{{name.snakeCase()}}_model.dart";

import "store.dart";

/// [{{name.pascalCase()}}sView] of the app.
@RoutePage()
class {{name.pascalCase()}}sView extends StatelessWidget {
  /// [{{name.pascalCase()}}sView] constructor.
  {{name.pascalCase()}}sView({super.key});

  /// [store] is an instance of [Addit{{name.pascalCase()}}sStore], used in the [LoadStateBuilder].
  /// TODO: Move to Managers if requiring global state of store.
  final Addit{{name.pascalCase()}}sStore store = Addit{{name.pascalCase()}}sStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("{{name.titleCase()}}s"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.navigateTo({{name.pascalCase()}}Route()),
        child: const Icon(Icons.add),
      ),
      body: LoadStateBuilder(
        viewStore: store,
        emptyBuilder: (context) => const Center(child: Text("Start creating {{name.titleCase()}}s")),
        loadedBuilder: (context) => ListView.builder(
          itemCount: store.{{name.camelCase()}}s.length,
          itemBuilder: (context, index) {
            final {{name.camelCase()}}sModel = store.{{name.camelCase()}}s[index];
            if ({{name.camelCase()}}sModel == null) {
              return const SizedBox.shrink();
            }
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
                    Sizes.l.spacer(vertical: false),
                  ],
                ),
              ),
              child: ListTile(
                title: Text({{name.camelCase()}}sModel.id),                
                onTap: () => context.navigateTo({{name.pascalCase()}}Route(id: {{name.camelCase()}}sModel.id, {{name.camelCase()}}Model: {{name.camelCase()}}sModel)),
              ),
            );
          },
        ),
        errorBuilder: (context) => const Center(
          child: Text("Error loading {{name.camelCase()}}s view."),
        ),
      ),
    );
  }
}
