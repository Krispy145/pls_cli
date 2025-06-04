{{#has_firebase}}
// import "package:firebase_core/firebase_core.dart";
// import "package:firebase_crashlytics/firebase_crashlytics.dart";
{{/has_firebase}}
import "package:{{project_name.snakeCase()}}/app.dart";
import "package:{{project_name.snakeCase()}}/dependencies/injection.dart";
import "package:{{project_name.snakeCase()}}/environments/prod/env.dart";
import "package:{{project_name.snakeCase()}}/config/store.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:flutter/services.dart";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:theme/utils/loggers.dart";
import 'package:{{project_name.snakeCase()}}/flavors.dart';

{{#has_firebase}}
// import "../../firebase/firebase_options_prod.dart";
{{/has_firebase}}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final loggerFeatures = <Enum, bool>{
    ThemeLoggers.theme: true,
  };

if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  
  final config = ConfigStore(
    environmentName: Flavor.production.name,
    loggerFeatures: loggerFeatures,
    domain: kDebugMode ? "http://localhost:8060" : StageEnv.domain,
  );

  {{#has_firebase}}
  // TODO: Uncomment this after adding the firebase_options_prod.dart file
  //Initialize firebase project
  // await Firebase.initializeApp(
  //   name: !kIsWeb ? config.environment?.name : null,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // if (!kIsWeb) {
  //   // Pass all uncaught "fatal" errors from the framework to Crashlytics
  //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  //   // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  //   PlatformDispatcher.instance.onError = (error, stack) {
  //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //     return true;
  //   };
  // }

  {{/has_firebase}}
  Managers.init(config: config);
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );
  FlutterNativeSplash.remove();

  runApp(const MainApp());
}
