import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:{{project_name.snakeCase()}}/auth/_auth.dart';
import 'package:{{project_name.snakeCase()}}/home/_home.dart';
import 'package:{{project_name.snakeCase()}}/welcome/_welcome.dart';
import 'package:{{project_name.snakeCase()}}/navigation/_navigation.dart';

part 'router_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  final AuthBloc authBloc;

  AppRouter({
    required this.authBloc,
  });

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: "/splash", page: SplashRoute.page),
        AutoRoute(path: "/onboarding", page: OnboardingRoute.page),
        AutoRoute(path: "/register", page: RegisterRoute.page),
        AutoRoute(path: "/login", page: LoginRoute.page),
        AutoRoute(
          path: "/login/forgotten-password",
          page: ForgottenPasswordRoute.page,
        ),
        AutoRoute(
          path: "/login/reset-password",
          page: ResetPasswordRoute.page,
        ),
        AutoRoute(
          path: "/",
          page: AuthenticatedRoute.page,
          guards: [AuthGuard(authBloc)],
          children: [
            CustomRoute(
              path: "home",
              page: HomeRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
            ),
          ],
        ),
      ];
}
