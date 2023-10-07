import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/presentation/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const {{name.pathCase()}}Route = TypedGoRoute<{{name.titleCase()}}Route>(path: '{{name.pathCase()}}');

class {{name.titleCase()}}Route extends GoRouteData {
  const {{name.titleCase()}}Route();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{name.titleCase()}}View();
  }
}
