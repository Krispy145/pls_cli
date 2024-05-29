import "package:authentication/data/models/auth_params.dart";
import "package:authentication/presentation/builder.dart";
import "package:authentication/presentation/components/social_types.dart";
import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:utilities/sizes/spacers.dart";
import '/navigation/components/app_bar.dart';
import "/dependencies/injection.dart";
import "/navigation/routes.gr.dart";

/// [UserAuthView] of the app.
@RoutePage()
class UserAuthView extends StatelessWidget {
  /// [UserAuthView] constructor.
  const UserAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar: MainAppBar(
        title: "Sign In or Sign Up",
        ),
      body: Column(
        children: [
          Sizes.xl.spacer(),
          AuthenticationBuilder(
            repository: Managers.authenticationRepository,            
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
