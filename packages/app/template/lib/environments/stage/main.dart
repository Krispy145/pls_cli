/// FIREBASE START
// import "package:firebase_core/firebase_core.dart";
// import "package:firebase_crashlytics/firebase_crashlytics.dart";
/// FIREBASE END
import "package:app_template/app.dart";
import "package:app_template/dependencies/injection.dart";
import "package:app_template/environments/config.dart";
import "package:app_template/environments/stage/env.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:theme/utils/loggers.dart";

/// FIREBASE START
// import "../../firebase/firebase_options_stage.dart";
/// FIREBASE END

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loggerFeatures = <Enum, bool>{
    ThemeLoggers.theme: true,
  };

  final config = Config(
    StageEnv.name,
    key1: StageEnv.key1,
    loggerFeatures: loggerFeatures,
    apiPrefix: "stage_base_url",
  );

  Managers.init(config: config);

  /// FIREBASE START
  // TODO: Uncomment this after adding the firebase_options_stage.dart file
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

  /// FIREBASE END

  runApp(const MainApp());
}
