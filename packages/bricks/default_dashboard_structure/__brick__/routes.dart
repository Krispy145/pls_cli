import 'package:auto_route/auto_route.dart';

import 'routes.gr.dart';

/// [AppRouter] is the router of the app.
@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: DefaultWrapperRoute.page, children: [
          AutoRoute(
            initial: true,
            page: DashboardWrapperRoute.page,
            children: const [],
          ),
        ]),
      ];
}
