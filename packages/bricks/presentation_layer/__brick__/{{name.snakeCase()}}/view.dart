import 'package:flutter/material.dart';
import 'package:utilities/widgets/load_state/state_widget.dart';

import 'store.dart';

/// [{{name.pascalCase()}}View] of the app.
class {{name.pascalCase()}}View extends StatelessWidget {
  /// [{{name.pascalCase()}}View] constructor.
  {{name.pascalCase()}}View({super.key});

  /// [store] is an instance of [{{name.pascalCase()}}Store], used in the [LoadStateBuilder].
  final {{name.pascalCase()}}Store store = {{name.pascalCase()}}Store()..load{{name.pascalCase()}}Models();

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: store,
      emptyBuilder: (context) => const Center(
        child: Text("Empty {{name.camelCase()}} view."),
      ),
      loadedBuilder: (context) => ListView.builder(
        itemCount: store.{{name.camelCase()}}s.length,
        itemBuilder: (context, index) {
          final {{name.camelCase()}}Model = store.{{name.camelCase()}}s[index]!;
          return ListTile(
            title: Text('ID: ${{{name.camelCase()}}Model.id}'),
            subtitle: Text('Name: ${{{name.camelCase()}}Model?.name}'),
          );
        },
      ),
      errorBuilder: (context) => const Center(
        child: Text("Error loading {{name.camelCase()}} view."),
      ),
    );
  }
}
