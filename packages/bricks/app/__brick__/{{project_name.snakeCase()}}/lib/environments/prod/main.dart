{{#has_firebase}}
// import "package:firebase_core/firebase_core.dart";
// import "package:firebase_crashlytics/firebase_crashlytics.dart";
{{/has_firebase}}
import "package:{{project_name.snakeCase()}}/app.dart";
import "package:{{project_name.snakeCase()}}/dependencies/injection.dart";
import "package:{{project_name.snakeCase()}}/environments/config.dart";
import "package:{{project_name.snakeCase()}}/environments/prod/env.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:theme/utils/loggers.dart";

{{#has_firebase}}
// import "../../firebase/firebase_options_prod.dart";
{{/has_firebase}}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loggerFeatures = <Enum, bool>{
    ThemeLoggers.theme: true,
  };

  final config = Config(
    ProdEnv.name,
    loggerFeatures: loggerFeatures,
    apiPrefix: "prod_base_url",
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

  runApp(const MainApp());
}
