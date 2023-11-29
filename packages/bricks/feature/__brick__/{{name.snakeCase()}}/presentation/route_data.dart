import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view.dart';

/// [{{name.camelCase()}}Route] is a top level [GoRoute] that defines the {{name.camelCase()}} route of the app.
const {{name.camelCase()}}Route = TypedGoRoute<{{name.pascalCase()}}Route>(path: '{{name.snakeCase()}}');

/// [{{name.pascalCase()}}Route] is a class that extends [GoRouteData] and defines the main route data.
class {{name.pascalCase()}}Route extends GoRouteData {
  /// [{{name.pascalCase()}}Route] constructor.
  const {{name.pascalCase()}}Route();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{name.pascalCase()}}View();
  }
}
