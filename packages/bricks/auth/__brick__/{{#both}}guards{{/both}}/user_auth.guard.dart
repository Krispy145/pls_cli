import "dart:async";

import "package:authentication/data/models/auth_params.dart";
import "package:auto_route/auto_route.dart";

import "/dependencies/injection.dart";
import "/navigation/routes.gr.dart";

/// [UserAuthGuard] is the guard for authentication.
class UserAuthGuard implements AutoRouteGuard {
  final PageRouteInfo<dynamic> nextRoute;

  /// [UserAuthGuard] constructor.
  const UserAuthGuard({required this.nextRoute});
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final user = Managers.authenticationRepository.currentUserModelStream.value;
    final authStatus = user?.status ?? AuthStatus.unauthenticated;
    if (authStatus == AuthStatus.authenticated && user?.authType != AuthType.anonymous) {
      resolver.next();
    } else {
      await router.replace(
        UserAuthRoute(
          onSuccess: (user) => router.replace(nextRoute),
        ),
      );
    }
  }
}
