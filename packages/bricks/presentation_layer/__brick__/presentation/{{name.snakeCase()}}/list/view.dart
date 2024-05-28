import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:utilities/data/models/{{name.snakeCase()}}_model.dart";
import "package:utilities/layouts/paginated_list/builder.dart";
import "package:utilities/widgets/load_state/builder.dart";

import "store.dart";

/// [{{name.pascalCase()}}sView] of the app.
@RoutePage()
class {{name.pascalCase()}}sView extends StatelessWidget {
  /// [{{name.pascalCase()}}sView] constructor.
  {{name.pascalCase()}}sView({super.key});

  /// [store] is an instance of [{{name.pascalCase()}}sStore], used in the [LoadStateBuilder].
  final {{name.pascalCase()}}sStore store = {{name.pascalCase()}}sStore();

  @override
  Widget build(BuildContext context) {
    return PaginatedListBuilder<{{name.pascalCase()}}Model>.listView(
      store: store,
      itemBuilder: (context, index) {
        final {{name.camelCase()}}Model = store.results[index]!;
        return ListTile(
          title: Text({{name.camelCase()}}Model.id),
          subtitle: Text("Name: ${{{name.camelCase()}}Model?.name}"),
        );
      },
    );
  }
}
