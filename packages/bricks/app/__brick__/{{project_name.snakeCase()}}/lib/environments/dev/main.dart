{{#has_firebase}}
// import "package:firebase_core/firebase_core.dart";
// import "package:firebase_crashlytics/firebase_crashlytics.dart";
{{/has_firebase}}
import "package:{{project_name.snakeCase()}}/app.dart";
import "package:{{project_name.snakeCase()}}/dependencies/injection.dart";
import "package:{{project_name.snakeCase()}}/environments/config.dart";
import "package:{{project_name.snakeCase()}}/environments/dev/components/app_bar.dart";
import "package:{{project_name.snakeCase()}}/environments/dev/env.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:theme/utils/loggers.dart";

{{#has_firebase}}
// import "../../firebase/firebase_options_dev.dart";
{{/has_firebase}}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loggerFeatures = <Enum, bool>{
    ThemeLoggers.theme: true,
  };

  final config = Config(
    DevEnv.name,
    loggerFeatures: loggerFeatures,
    apiPrefix: "dev_base_url",
  );
  

  {{#has_firebase}}
  // TODO: Uncomment this after adding the firebase_options_dev.dart file
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

  runApp(
    config.showDevTools ? const DevApp() : const MainApp(),
  );
}

class DevApp extends StatelessWidget {
  const DevApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DevBody(),
    );
  }
}

class DevBody extends StatelessWidget {
  const DevBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DevAppBar(),
      body: MainApp(),
    );
  }
}
