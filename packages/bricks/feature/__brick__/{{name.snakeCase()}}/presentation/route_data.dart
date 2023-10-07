import '../../presentation/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const {{name.pathCase()}}Route = TypedGoRoute<{{name.pascalCase()}}Route>(path: '{{name.pathCase()}}');

class {{name.pascalCase()}}Route extends GoRouteData {
  const {{name.pascalCase()}}Route();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return {{name.pascalCase()}}View();
  }
}
