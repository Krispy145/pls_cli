import "dart:async";

import "package:authentication/data/models/auth_params.dart";
import "package:auto_route/auto_route.dart";

import "/dependencies/injection.dart";
import "/navigation/routes.gr.dart";

/// [AuthGuard] is the guard for authentication.
class AuthGuard implements AutoRouteGuard {
  final PageRouteInfo<dynamic>? nextRoute;

  /// [AuthGuard] constructor.
  const AuthGuard({this.nextRoute});
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final user = Managers.authenticationRepository.currentUserModelStream.value;
    final authStatus = user?.status ?? AuthStatus.unauthenticated;
    final authStatus = user?.status ?? AuthStatus.unauthenticated;
    if (authStatus == AuthStatus.authenticated) {
      resolver.next();
    } else {
      await router.replace(
        AuthRoute(
          onSuccess: nextRoute != null ? (user) => router.navigate(nextRoute!) : null,
        ),
      );
    }
  }
}
