import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:navigation/structures/map/widget.dart';
import 'package:new_setup/navigation/routes.gr.dart';

import '/dependencies/injection.dart';

/// [MapWrapperView] is a class that defines the default wrapper of the app
/// This returns the selected app structure.
@RoutePage()
class MapWrapperView extends StatelessWidget {
  /// [MapWrapperView] constructor.
  MapWrapperView({super.key});

  final _mapShellStore = Managers.mapShellStore;

  @override
  Widget build(BuildContext context) {
    return MapShellStructure.left(
      store: _mapShellStore,
      overlayPercentage: 0.25,
      map: const Center(
        child: Center(
          child: GestureDetector(
            onTap: _mapShellStore.toggleOverlay,
            child: const Text("This is a map structure"),
          ),
        ),
      ),
    );
  }
}
