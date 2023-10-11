import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view.dart';

/// [homeRoute] is a top level [GoRoute] that defines the home route of the app.
const homeRoute = TypedGoRoute<HomeRoute>(path: 'home');

/// [HomeRoute] is a class that extends [GoRouteData] and defines the home route data.
class HomeRoute extends GoRouteData {
  /// [HomeRoute] constructor.
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomeView();
  }
}
