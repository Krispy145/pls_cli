import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{project_name.snakeCase()}}/auth/_auth.dart';
import 'package:{{project_name.snakeCase()}}/navigation/_navigation.dart';

import 'config/_config.dart';
import 'core/_core.dart';
import 'l10n/l10n.dart';

class App extends StatefulWidget {
  /// Allow setting different observers for testing, staging and production
  final List<NavigatorObserver> Function()? observers;
  const App({super.key, this.observers});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthBloc _authBloc;
  final _errorMessengerKey = GlobalKey<ScaffoldMessengerState>();

  late final AppRouter router;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc()..add(AuthCheckRequested());
    router = AppRouter(authBloc: _authBloc);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GlobalErrorCubit(), lazy: false),
        BlocProvider.value(value: _authBloc),
        BlocProvider(create: (context) => SettingsCubit()),
      ],
      child: BlocListener<GlobalErrorCubit, String?>(
        listener: _errorListener,
        child: MaterialApp.router(
          title: '{{project_name.snakeCase()}}',
          scaffoldMessengerKey: _errorMessengerKey,
          routerConfig: router.config(
            navigatorObservers: () {
              final observers = widget.observers?.call();
              return [
                AppRouteObserver(),
                if (observers != null) ...observers,
              ];
            },
            reevaluateListenable: ReevaluateListenable.stream(_authBloc.stream),
            deepLinkBuilder: (_) => const DeepLink([
              SplashRoute(),
            ]),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: theme,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  void _errorListener(BuildContext _, String? state) {
    if (state != null) {
      _errorMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(state),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
