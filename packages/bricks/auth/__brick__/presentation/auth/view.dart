import "package:authentication/data/models/auth_params.dart";
import "package:authentication/presentation/builder.dart";
import "package:authentication/presentation/components/social_types.dart";
import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:utilities/sizes/spacers.dart";

import "/dependencies/injection.dart";
import "/navigation/routes.gr.dart";

/// [AuthView] of the app.
@RoutePage()
class AuthView extends StatelessWidget {
  /// [AuthView] constructor.
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign In or Sign Up",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Column(
        children: [
          Sizes.xl.spacer(),
          AuthenticationBuilder(
            repository: Managers.authenticationRepository,
            onSuccess: (userModel) => context.router.navigate(const DefaultWrapperRoute()),
            // showPhoneAuth: ShowAuthAction(showSignUp: false, showSignIn: true),
            socialTypes: [
              SocialButtonType.apple(params: AuthParams.apple()),
              SocialButtonType.google(params: AuthParams.google()),
            ],
          ),
        ],
      ),
    );
  }
}
