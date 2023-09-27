import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('New route pop: ${route.settings.name}');
  }
}
