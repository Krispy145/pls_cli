import 'package:flutter/material.dart';
import 'package:utilities/widgets/load_state/state_widget.dart';

import 'store.dart';

/// [MainView] of the app.
class MainView extends StatelessWidget {
  /// [MainView] constructor.
  MainView({super.key});

  /// [store] is an instance of [MainStore], used in the [LoadStateBuilder].
  final MainStore store = MainStore()..loadMainModels();

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: store,
      emptyBuilder: (context) => const Center(
        child: Text("Empty main view."),
      ),
      loadedBuilder: (context) => ListView.builder(
        itemCount: store.mains.length,
        itemBuilder: (context, index) {
          final mainModel = store.mains[index];
          return ListTile(
            title: Text('Name: ${mainModel?.name}'),
            subtitle: Text('Age: ${mainModel?.age}'),
          );
        },
      ),
      errorBuilder: (context) => const Center(
        child: Text("Error loading main view."),
      ),
    );
  }
}
