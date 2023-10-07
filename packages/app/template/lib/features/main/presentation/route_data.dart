import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view.dart';

class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainView();
  }
}
