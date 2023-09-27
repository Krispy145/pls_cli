import 'package:auto_route/auto_route.dart';
import 'package:flutter_template/navigation/_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/_core.dart';

import '../../auth/blocs/auth/auth_bloc.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TickerFuture? _animationFuture;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationFuture = _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _navigate,
      child: Scaffold(
        backgroundColor: const Color(0xff0E1D40),
        body: FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(Assets.archLogoPng),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigate(BuildContext context, AuthState state) async {
    final isAuthorized = state.status == AuthStatus.authorised;

    final router = context.router;

    if (state.status == AuthStatus.initial) {
      return;
    }

    if (_animationFuture != null) {
      await _animationFuture;
    }

    if (isAuthorized) {
      await router.replace(
        const AuthenticatedRoute(
          children: [HomeRoute()],
        ),
      );
      return;
    }

    router.replace(const OnboardingRoute());
  }
}
