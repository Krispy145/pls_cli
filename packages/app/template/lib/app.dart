//FIREBASE START
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
//FIREBASE END
import 'package:flutter/material.dart';
import 'package:flutter_template/dependency_injection/injection_container.dart';
//FIREBASE START
import 'package:flutter_template/firebase/firebase_options_staging.dart';
//FIREBASE END
import 'package:flutter_template/navigation/routes.dart';
import 'package:utilities/flavors/flavor_config.dart';

/// Main App Function
void appMain({required FlavorConfig flavorConfig})  {
  Managers.init(flavorConfig: flavorConfig);
  
  //FIREBASE START
  if (!kIsWeb) {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics  
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  //FIREBASE END
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Template',
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: themeManager.themeMode,
      routerConfig: AppRouter.router(
        
        //FIREBASE START
        observers: !kIsWeb?[FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)]:null,
        //FIREBASE END
      ),
    );
  }
}
