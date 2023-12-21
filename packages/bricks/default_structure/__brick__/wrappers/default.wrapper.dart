import 'package:app_template/dependencies/injection.dart';
import 'package:app_template/navigation/components/app_bar.dart';
import 'package:app_template/navigation/components/bottom_nav_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:navigation/structures/default_shell_structure/widget.dart';
import 'package:utilities/helpers/tuples.dart';

/// [DefaultWrapperView] is a class that defines the default wrapper of the app
/// This returns the selected app structure.
@RoutePage()
class DefaultWrapperView extends StatelessWidget {
  /// [navigator] is the navigator of the app.
  final Widget navigator;

  /// [DefaultWrapperView] constructor.
  const DefaultWrapperView({super.key, required this.navigator});

  @override
  Widget build(BuildContext context) {
    return DefaultShellStructure(
      store: Managers.defaultShellStore,
      appBar: const MainAppBar(),
      bottomNavigationBar: MainBottomNavBar(
        iconButtons: [
          Pair(Icons.home, () => context.navigateTo(HomeRoute())),
        ],
      ),
    );
  }
}
