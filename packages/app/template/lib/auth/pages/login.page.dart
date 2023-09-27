import 'package:auto_route/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../core/_core.dart';
import '../_auth.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  final String? fromPage;
  const LoginPage({Key? key, this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return RemoveFocusWrapper(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  height: constraints.maxHeight,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                              ),
                              child: Text(
                                locale.loginTitle,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            const Expanded(child: LoginForm()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
