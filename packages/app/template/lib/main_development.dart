///THIS PAGE IS ONLY FOR DEVELOPMENT PURPOSES
/// IT IS OVERWRITTEN WHEN GENERATING THE TEMPLATE
import 'dart:async';

import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_overlay/flutter_dev_overlay.dart';

import 'app.dart';
import 'auth/repositories/auth.repo.dart';
import 'bootstrap.dart';
import 'config/models/config.dart';

// flutter build -t lib/main_development.dart --flavor development
void main() async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();

  await Config.instance.initialize("config/development.json", Environment.dev);

  unawaited(
    bootstrap(
      (locator) => FlutterDevOverlay(
        onAccessTokenRemoved: () async {
          TokenService.instance.removeAccessToken();
        },
        onCopyAccessTokenToClipboard: () async {
          final token = TokenService.instance.tokenInfo?.token;
          await Clipboard.setData(
            ClipboardData(text: token ?? ""),
          );
          return token;
        },
        onRefreshTokenRemoved: () async {
          await TokenService.instance.removeRefreshToken();
        },
        onLoginPressed: () => locator<AuthRepository>().loginWithEmail(
          email: "dan@digitaloasis.com",
          password: "Testertester1!",
        ),
        child: const App(),
      ),
    ),
  );
}
