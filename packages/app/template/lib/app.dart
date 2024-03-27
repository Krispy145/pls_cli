import 'package:app_template/dependencies/injection.dart';
import 'package:app_template/environments/config.dart';

/// FIREBASE START
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// FIREBASE END
import 'package:flutter/material.dart';
import 'package:theme/app/view.dart';
import 'package:utilities/flavors/flavor_config.dart';

/// Main App Function
void appMain({required Config config}) {
  Managers.init(config: config);

  /// FIREBASE START
  if (!kIsWeb) {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      config.environment == Environment.production ? FirebaseCrashlytics.instance.recordError(error, stack) : FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  /// FIREBASE END
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
        title: 'App Template',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: currentThemeMode,
        routerConfig: Managers.router.config(
          /// FIREBASE START
          navigatorObservers: () => !kIsWeb
              ? [
                  FirebaseAnalyticsObserver(
                    analytics: FirebaseAnalytics.instance,
                  ),
                ]
              : [],

          /// FIREBASE END
        ),
      ),
    );
  }
}
