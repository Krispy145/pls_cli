
import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/dependency_injection/injection_container.dart';
import 'package:{{project_name.snakeCase()}}/src/presentation/main/route_data.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/structures/default_shell_structure/widget.dart';


part 'routes.g.dart';

// Router class responsible for specifying routes and configuring router.
class AppRouter {
  static final router = GoRouter(routes: $appRoutes);
}

//Main Tree of App LifeCycle (To be updated to include all routes and nested routes within the app)

@TypedShellRoute<MainShellRoute>(
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<MainRoute>(path: '/', routes: <TypedGoRoute<GoRouteData>>[
      ///MAIN ROUTES END
    ],)
  ],
)
class MainShellRoute extends ShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) => MainShell(body: navigator);
}

class MainShell extends StatelessWidget {
  final Widget body;
  const MainShell({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return DefaultShellStructure(
      store: Managers.defaultShellStore,
      appBar: AppBar(
        title: const Column(
          children: [
            Text("{{project_name.titleCase()}}"),
          ],
        ),
      ),
      body: body,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 30,
                onPressed: () => const MainRoute().go(context),
                icon: const Icon(Icons.home),
              ),                            
            ],
          ),          
        ],
      ),
    );
  }
}
