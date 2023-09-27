import 'package:api/api.dart';
import 'package:flutter_template/auth/_auth.dart';
import 'package:get_it/get_it.dart';

import '../../config/_config.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  final config = Config.instance;
  locator
    ..registerLazySingleton(SettingsRepository.new)
    ..registerLazySingleton(AuthRepository.new)
    ..registerLazySingleton<ClientSdk>(
      () => ClientSdk(
        isDev: config.isDev,
        baseUrl: config.baseUrl,
        clientId: config.clientId,
        clientSecret: config.clientSecret,
      ),
    );
}

/// Used to register/set up singletons on the `loggedIn` [GetIt] scope.
///
/// Useful for retrieving locally saved files once the user has logged in.
// ignore: avoid-unused-parameters
void postLoginSetup(String userId, GetIt i) {}
