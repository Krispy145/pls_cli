import 'package:app_template/dependencies/injection.dart';
import 'package:app_template/features/home/presentation/route_data.dart';
import 'package:app_template/navigation/components/app_bar.dart';
import 'package:app_template/navigation/components/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/structures/dashboard_shell_structure/shell/widget.dart';
import 'package:utilities/helpers/tuples.dart';

import '../../../navigation/branches/board/branch_data.dart';

part 'routes.g.dart';

/// Router class responsible for specifying routes and configuring router.
class AppRouter {
  /// [AppRouter] constructor.
  static GoRouter router({List<NavigatorObserver>? observers}) => GoRouter(routes: $appRoutes, observers: observers);
}

/// Main Tree of App LifeCycle (To be updated to include all routes and nested routes within the app)
@TypedStatefulShellRoute<MainShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<StatefulShellBranchData>(
      routes: <TypedShellRoute<ShellRouteData>>[
        TypedShellRoute<BoardShellRoute>(routes: <TypedGoRoute<GoRouteData>>[homeRoute])
      ],
    ),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  /// [MainShellRoute] constructor.
  const MainShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) => MainShell(navigator: navigationShell);
}

/// [MainShell] is a class that defines the main shell of the app.
/// This returns the selected app structure.
class MainShell extends StatelessWidget {
  /// [navigator] is the navigator of the app.
  final StatefulNavigationShell navigator;

  /// [MainShell] constructor.
  const MainShell({super.key, required this.navigator});

  @override
  Widget build(BuildContext context) {
    return DashboardShellStructure(
      store: Managers.dashboardShellStore,
      appBar: const MainAppBar(),
      shell: navigator,
      floatingActionButton: MainBottomNavBar(
        iconButtons: [
          Pair(
            Icons.home,
            () => Managers.dashboardShellStore.onNavigateToBranch(navigator, 0),
          ),
        ],
      ),
    );
  }
}
