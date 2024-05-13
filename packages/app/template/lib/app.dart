/// FIREBASE START
import "package:firebase_analytics/firebase_analytics.dart";
/// FIREBASE END
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:theme/app/view.dart";
import "package:app_template/dependencies/injection.dart";

/// Main App Class
class MainApp extends StatelessWidget {
  /// Main App Constructor
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedMaterialApp(
      themeStore: Managers.themeStateStore,
      materialAppBuilder: (lightTheme, darkTheme, currentThemeMode) {
        return MaterialApp.router(
          title: "App Template",
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentThemeMode,
          routerConfig: Managers.router.config(
            navigatorObservers: () =>             
            /// FIREBASE START
            !kIsWeb
                ? [
                    FirebaseAnalyticsObserver(
                      analytics: FirebaseAnalytics.instance,
                    ),
                  ]
                : 
            /// FIREBASE END
                [],
          ),
        );
      },
    );
  }
}
