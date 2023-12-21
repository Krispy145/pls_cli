import 'package:{{project_name.snakeCase()}}/features/home/presentation/route_data.dart';
import 'package:{{project_name.snakeCase()}}/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/structures/dashboard_shell_structure/branches/board_branch/widget.dart';

/// Board Shell Route
class BoardShellRoute extends ShellRouteData {
  /// [BoardShellRoute] constructor.
  const BoardShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      BoardShell(navigator: navigator);
}

/// Board Shell
class BoardShell extends StatefulWidget {
  /// [navigator] is the navigator of the board shell.
  final Widget navigator;

  /// [BoardShell] constructor.
  const BoardShell({super.key, required this.navigator});

  @override
  State<BoardShell> createState() => _BoardShellState();
}

class _BoardShellState extends State<BoardShell> {
  @override
  Widget build(BuildContext context) {
    return BoardBranchShellStructure.left(
      boardNavigationRailPercentage: 0.2,
      destinations: List.generate(
        20,
        (index) => NavigationRailDestination(
          icon: const Icon(Icons.calendar_today_outlined),
          selectedIcon: const Icon(Icons.calendar_month_rounded),
          label: Text('Calendar ${index + 1}'),
        ),
      ),
      onSelectedCallback: (index) => const HomeRoute().push<HomeRoute>(context),
      boardNavigator: widget.navigator,
    );
  }
}
