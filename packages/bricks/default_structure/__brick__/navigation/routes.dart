import 'package:app_template/dependencies/injection.dart';
import 'package:app_template/features/home/presentation/route_data.dart';
import 'package:app_template/features/main/presentation/route_data.dart';
import 'package:app_template/navigation/components/app_bar.dart';
import 'package:app_template/navigation/components/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/structures/default_shell_structure/widget.dart';
import 'package:utilities/helpers/tuples.dart';

part 'routes.g.dart';

/// Router class responsible for specifying routes and configuring router.
class AppRouter {
  /// [AppRouter] constructor.
  static GoRouter router({List<NavigatorObserver>? observers}) =>
      GoRouter(routes: $appRoutes, observers: observers);
}

/// Main Tree of App LifeCycle (To be updated to include all routes and nested routes within the app)
@TypedShellRoute<MainShellRoute>(
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<MainRoute>(
      path: '/',
      routes: <TypedGoRoute<GoRouteData>>[
        homeRoute,

        ///MAIN ROUTES END
      ],
    ),
  ],
)
class MainShellRoute extends ShellRouteData {
  /// [MainShellRoute] constructor.
  const MainShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      MainShell(navigator: navigator);
}

/// [MainShell] is a class that defines the main shell of the app.
/// This returns the selected app structure.
class MainShell extends StatelessWidget {
  /// [navigator] is the navigator of the app.
  final Widget navigator;

  /// [MainShell] constructor.
  const MainShell({super.key, required this.navigator});

  @override
  Widget build(BuildContext context) {
    return DefaultShellStructure(
      store: Managers.defaultShellStore,
      appBar: const MainAppBar(),
      navigator: navigator,
      bottomNavigationBar: MainBottomNavBar(
        iconButtons: [
          Pair(Icons.home, () => const HomeRoute().go(context)),
        ],
      ),
    );
  }
}
