import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:theme/extensions/build_context.dart";
import "/data/models/{{name.snakeCase()}}_model.dart";
import "package:utilities/widgets/load_state/builder.dart";

import "store.dart";

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          return Center(
            child:Text(
                  store.isEmpty ? "Empty {{name.pascalCase()}}" : "store.current{{name.pascalCase()}}?.name",
                  style: context.textTheme.headlineMedium,
                ),
          );
        },
      ),
    );
  }
}
