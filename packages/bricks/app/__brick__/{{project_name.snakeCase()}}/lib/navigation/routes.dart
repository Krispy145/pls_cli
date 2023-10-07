import 'package:{{project_name.snakeCase()}}/features/home/presentation/route_data.dart';
import 'package:{{project_name.snakeCase()}}/features/main/presentation/route_data.dart';
import 'package:{{project_name.snakeCase()}}/navigation/components/app_bar.dart';
import 'package:{{project_name.snakeCase()}}/navigation/components/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/dependency_injection/injection_container.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/structures/default_shell_structure/widget.dart';
import 'package:utilities/helpers/tuples.dart';

part 'routes.g.dart';

/// Router class responsible for specifying routes and configuring router.
class AppRouter {
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
    )
  ],
)
class MainShellRoute extends ShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) => MainShell(body: navigator);
}

class MainShell extends StatelessWidget {
  final Widget body;
  const MainShell({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return DefaultShellStructure(
      store: Managers.defaultShellStore,
      appBar: MainAppBar(),
      body: body,
      bottomNavigationBar: MainBottomNavBar(
        iconButtons: [
          Pair(Icons.home, () => const HomeRoute().go(context)),
        ],
      ),
    );
  }
}
