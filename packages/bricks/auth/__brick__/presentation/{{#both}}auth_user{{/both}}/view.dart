import "package:authentication/data/models/auth_params.dart";
import "package:authentication/data/models/user_model.dart";
import "package:authentication/presentation/auth/builder.dart";
import "package:authentication/presentation/auth/components/social_types.dart";
import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:utilities/sizes/spacers.dart";

import "/dependencies/injection.dart";
import "/navigation/components/app_bar.dart";

/// [UserAuthView] of the app.
@RoutePage()
class UserAuthView extends StatelessWidget {
  final void Function(UserModel)? onSuccess;

  /// [UserAuthView] constructor.
  const UserAuthView({super.key, this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: "Sign In or Sign Up",
      ),
      body: Column(
        children: [
          Sizes.xl.spacer(),
          AuthenticationBuilder.authenticate(
            repository: Managers.authenticationRepository,
            onSuccess: onSuccess,
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
