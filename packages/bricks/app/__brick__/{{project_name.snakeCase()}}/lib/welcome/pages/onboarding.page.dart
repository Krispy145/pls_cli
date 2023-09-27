import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/navigation/_navigation.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboarding"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Register Now..."),
          onPressed: () => context.pushRoute(const RegisterRoute()),
        ),
      ),
    );
  }
}
