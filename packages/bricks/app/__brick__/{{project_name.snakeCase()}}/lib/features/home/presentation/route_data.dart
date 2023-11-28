import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view.dart';

/// [HomeRoute] is a class that extends [GoRouteData] and defines the main route data.
class HomeRoute extends GoRouteData {
  /// [HomeRoute] constructor.
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomeView();
  }
}
