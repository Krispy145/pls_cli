import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/src/presentation/main/widget.dart';

class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainView();
  }
}
