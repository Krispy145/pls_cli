import 'package:auto_route/auto_route.dart';

import '../../auth/_auth.dart';
import '../_navigation.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthBloc authBloc;

  AuthGuard(this.authBloc);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthorized = authBloc.state.status == AuthStatus.authorised;
    if (!isAuthorized) {
      router.replaceAll([
        LoginRoute(fromPage: resolver.route.path),
      ]);
    } else {
      resolver.next();
    }
  }
}
