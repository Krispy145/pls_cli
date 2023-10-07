import 'package:flutter_template/features/home/presentation/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const homeRoute = TypedGoRoute<HomeRoute>(path: 'home');

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HomeView();
  }
}
