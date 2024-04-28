{{#has_firebase}}
import "package:firebase_analytics/firebase_analytics.dart";
{{/has_firebase}}
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:theme/app/view.dart";
import "package:{{project_name.snakeCase()}}/dependencies/injection.dart";

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
          title: "{{project_name.titleCase()}}",
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentThemeMode,
          routerConfig: Managers.router.config(
            navigatorObservers: () =>             
            {{#has_firebase}}
            !kIsWeb
                ? [
                    FirebaseAnalyticsObserver(
                      analytics: FirebaseAnalytics.instance,
                    ),
                  ]
                : 
            ///  FIREBASE END
                [],
          ),
        );
      },
    );
  }
}
