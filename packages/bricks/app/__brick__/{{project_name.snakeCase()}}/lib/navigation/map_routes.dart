import 'package:{{project_name.snakeCase()}}/dependencies/injection.dart';
import 'package:{{project_name.snakeCase()}}/features/home/presentation/route_data.dart';
import 'package:{{project_name.snakeCase()}}/features/main/presentation/route_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/structures/map_shell_structure/widget.dart';

part 'routes.g.dart';

/// Router class responsible for specifying routes and configuring router.
class AppRouter {
  /// [AppRouter] constructor.
  static GoRouter router({List<NavigatorObserver>? observers}) => GoRouter(routes: $appRoutes, observers: observers);
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
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) => MainShell(navigator: navigator);
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
    return MapShellStructure.left(
      store: Managers.mapShellStore,
      navigator: navigator,
      overlayPercentage: 0.25,
      map: const Center(
        child: Text("This is a map structure"),
      ),
    );
  }
}
