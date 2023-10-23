import 'package:app_template/dependencies/injection.dart';

/// FIREBASE START
import 'package:app_template/firebase/firebase_options_staging.dart';

/// FIREBASE END
import 'package:app_template/navigation/routes.dart';

/// FIREBASE START
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// FIREBASE END
import 'package:flutter/material.dart';
import 'package:utilities/flavors/flavor_config.dart';
import 'package:utilities/theme/wrapper/wrapper.dart';

/// Main App Function
void appMain({required FlavorConfig flavorConfig}) {
  Managers.init(flavorConfig: flavorConfig);

  /// FIREBASE START
  if (!kIsWeb) {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
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
        routerConfig: AppRouter.router(
          /// FIREBASE START
          observers: !kIsWeb ? [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)] : null,

          /// FIREBASE END
        ),
      ),
    );
  }
}
