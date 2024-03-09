import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:navigation/structures/default/widget.dart';
import '/navigation/routes.gr.dart';
import 'package:utilities/helpers/tuples.dart';
import '../routes.gr.dart';
import '/dependencies/injection.dart';
import '/navigation/components/app_bar.dart';
import '/navigation/components/bottom_nav_bar.dart';

/// [DefaultWrapperView] is a class that defines the default wrapper of the app
/// This returns the selected app structure.
@RoutePage()
class DefaultWrapperView extends StatelessWidget {
  /// [DefaultWrapperView] constructor.
  const DefaultWrapperView({super.key});

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
