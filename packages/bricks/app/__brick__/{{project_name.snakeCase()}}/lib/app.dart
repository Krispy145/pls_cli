import 'package:{{project_name.snakeCase()}}/dependencies/injection.dart';
import 'package:{{project_name.snakeCase()}}/environments/config.dart';

{{#has_firebase}}
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

{{/has_firebase}}
import 'package:flutter/material.dart';
import 'package:theme/app/view.dart';
import 'package:utilities/flavors/flavor_config.dart';

/// Main App Function
void appMain({required Config config}) {
  Managers.init(config: config);

  {{#has_firebase}}
  if (!kIsWeb) {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      config.environment == Environment.production ? FirebaseCrashlytics.instance.recordError(error, stack) : FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  {{/has_firebase}}
  runApp(const MainApp());
}

/// Main App Class
class MainApp extends StatelessWidget {
  /// Main App Constructor
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedMaterialApp(
      themeStore: Managers.themeStateStore,
      materialAppBuilder: (lightTheme, darkTheme, currentThemeMode) => MaterialApp.router(
        title: '{{project_name.titleCase()}}',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: currentThemeMode,
        routerConfig: Managers.router.config(
          {{#has_firebase}}
          navigatorObservers: () => !kIsWeb
              ? [
                  FirebaseAnalyticsObserver(
                    analytics: FirebaseAnalytics.instance,
                  ),
                ]
              : [],

          {{/has_firebase}}
        ),
      ),
    );
  }
}
