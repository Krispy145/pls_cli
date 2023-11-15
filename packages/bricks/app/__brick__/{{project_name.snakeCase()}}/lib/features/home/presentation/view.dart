import 'package:flutter/material.dart';
import 'package:utilities/widgets/load_state/state_widget.dart';

import 'store.dart';

/// [HomeView] of the app.
class HomeView extends StatelessWidget {
  /// [HomeView] constructor.
  HomeView({super.key});

  /// [store] is an instance of [HomeStore], used in the [LoadStateBuilder].
  final HomeStore store = HomeStore()..loadHomeModels();

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: store,
      emptyBuilder: (context) => const Center(
        child: Text("Empty home view."),
      ),
      loadedBuilder: (context) => ListView.builder(
        itemCount: store.homes.length,
        itemBuilder: (context, index) {
          final homeModel = store.homes[index]!;
          return ListTile(
            title: Text('Name: ${homeModel.name}'),
            subtitle: Text('Age: ${homeModel.age}'),
          );
        },
      ),
      errorBuilder: (context) => const Center(
        child: Text("Error loading home view."),
      ),
    );
  }
}
