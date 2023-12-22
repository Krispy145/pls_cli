import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:navigation/structures/dashboard/widget.dart';

/// [DashboardWrapperView] is a class that defines the default wrapper of the app
/// This returns the selected app structure.
@RoutePage()
class DashboardWrapperView extends StatelessWidget {
  /// [DashboardWrapperView] constructor.
  DashboardWrapperView({super.key});

  final List<NavigationRailDestination> _destinations = [
    const NavigationRailDestination(
      icon: Icon(Icons.favorite_border),
      selectedIcon: Icon(Icons.favorite),
      label: Text('First'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.bookmark_border),
      selectedIcon: Icon(Icons.book),
      label: Text('Second'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.star_border),
      selectedIcon: Icon(Icons.star),
      label: Text('Third'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardShellStructure.left(
      navigationRailPercentage: 0.25,
      destinations: _destinations,
    );
  }
}
