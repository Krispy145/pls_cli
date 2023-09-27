import 'dart:async';

import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_overlay/flutter_dev_overlay.dart';
{{#has_firebase}}
import 'package:{{project_name.snakeCase()}}/firebase/firebase_options_development.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
{{/has_firebase}}
import 'app.dart';
import 'auth/repositories/auth.repo.dart';
import 'bootstrap.dart';
import 'config/models/config.dart';

// flutter build -t lib/main_development.dart
void main() async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();

  await Config.instance.initialize("config/development.json", Environment.dev);

  {{#has_firebase}}
  // Initialise [DEVELOPMENT] firebase project
  await Firebase.initializeApp(
    name: "development",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  {{/has_firebase}}

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
        showSubscriptionToggle: true,
        onRefreshTokenRemoved: () async {
          await TokenService.instance.removeRefreshToken();
        },
        onLoginPressed: () => locator<AuthRepository>().loginWithEmail(
          email: "",
          password: "",
        ),

        child: {{^has_firebase}}const{{/has_firebase}} App(
        {{#has_firebase}}
          observers: () => [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
          ],
          {{/has_firebase}}
        ),
      ),
    ),
  );
}
