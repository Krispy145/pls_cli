import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view.dart';

/// [MainRoute] is a class that extends [GoRouteData] and defines the main route data.
class MainRoute extends GoRouteData {
  /// [MainRoute] constructor.
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MainView();
  }
}
