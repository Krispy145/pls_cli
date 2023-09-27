import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AuthenticatedPage extends StatelessWidget {
  const AuthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Add any bloc providers that should be available to all authenticated routes
    return const AutoRouter();
  }
}
