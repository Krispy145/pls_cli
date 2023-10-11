import 'package:flutter/material.dart';
import 'package:utilities/widgets/load_state/state_widget.dart';
import 'store.dart';

/// [{{name.pascalCase()}}] is a component class.
class {{name.pascalCase()}} extends StatelessWidget {
  /// [{{name.pascalCase()}}] constructor.
  {{name.pascalCase()}}({super.key});

  /// [{{name.camelCase()}}Store] is a [{{name.pascalCase()}}Store] instance.
  final {{name.pascalCase()}}Store {{name.camelCase()}}Store = {{name.pascalCase()}}Store();
  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: {{name.camelCase()}}Store,
      loadedBuilder: (context) => const Center(
        child: Text("Loaded"),
      ),
      emptyBuilder: (context) => const Center(
        child: Text("Empty"),
      ),
      errorBuilder: (context) => const Center(
        child: Text("Error"),
      ),
    );
  }
}
