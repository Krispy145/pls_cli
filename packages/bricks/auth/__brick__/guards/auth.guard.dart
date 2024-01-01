import 'dart:async';

import 'package:authentication/data/models/auth_params.dart';
import 'package:auto_route/auto_route.dart';
import 'package:utilities/logger/logger.dart';

import '/dependencies/injection.dart';
import '/navigation/routes.gr.dart';

/// [AuthGuard] is the guard for authentication.
class AuthGuard implements AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final authStatus = Managers.authenticationRepository.currentUserModelStream.value?.status ?? AuthStatus.unauthenticated;
    AppLogger.print(
      "Supabase user AuthGuard: onNavigation => $authStatus",
      [LoggerFeatures.authentication],
    );
    if (authStatus == AuthStatus.authenticated) {
      resolver.next();
    } else {
      await router.replace(const AuthRoute());
    }
  }
}
