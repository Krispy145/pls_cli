import 'dart:async';

import 'package:flutter/material.dart';
{{#has_firebase}}
import 'package:{{project_name.snakeCase()}}/firebase/firebase_options_production.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
{{/has_firebase}}
import 'app.dart';
import 'bootstrap.dart';
import 'config/_config.dart';

// flutter build -t lib/main_development.dart
void main() async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();

  await Config.instance.initialize("config/production.json", Environment.prod);

  {{#has_firebase}}
  // Initialise [PRODUCTION] firebase project
  await Firebase.initializeApp(
    name: "production",
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
      (_) => {{^has_firebase}}const{{/has_firebase}} App(
       {{#has_firebase}} observers: () => [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
        ], {{/has_firebase}}
      ),
    ),
  );
}
