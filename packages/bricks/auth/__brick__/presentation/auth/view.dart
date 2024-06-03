import "package:authentication/data/models/user_model.dart";
import "package:authentication/presentation/auth/builder.dart";
import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:utilities/sizes/spacers.dart";

import "/dependencies/injection.dart";

/// [AuthView] of the app.
@RoutePage()
class AuthView extends StatelessWidget {
  final void Function(UserModel)? onSuccess;

  /// [AuthView] constructor.
  const AuthView({super.key, this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Sizes.xl.spacer(),
          AuthenticationBuilder.authenticateThenSilent(
            repository: Managers.authenticationRepository,
            onSuccess: onSuccess,
          ),
        ],
      ),
    );
  }
}
