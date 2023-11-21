import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view.dart';

/// [notificationsRoute] is a top level [GoRoute] that defines the notifications route of the app.
const notificationsRoute =
    TypedGoRoute<NotificationsRoute>(path: 'notifications');

/// [NotificationsRoute] is a class that extends [GoRouteData] and defines the notifications route data.
class NotificationsRoute extends GoRouteData {
  /// [NotificationsRoute] constructor.
  const NotificationsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NotificationsView();
  }
}
