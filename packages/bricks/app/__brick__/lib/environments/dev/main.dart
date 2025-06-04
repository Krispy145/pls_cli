{{#has_firebase}}
// import "package:firebase_core/firebase_core.dart";
// import "package:firebase_crashlytics/firebase_crashlytics.dart";
{{/has_firebase}}
import "package:{{project_name.snakeCase()}}/app.dart";
import "package:{{project_name.snakeCase()}}/dependencies/injection.dart";
import "package:{{project_name.snakeCase()}}/environments/dev/components/app_bar.dart";
import "package:{{project_name.snakeCase()}}/environments/dev/env.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:ai_me/flavors.dart";
import "package:theme/utils/loggers.dart";
import "package:{{project_name.snakeCase()}}/config/store.dart";
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:{{project_name.snakeCase()}}/flavors.dart';


{{#has_firebase}}
// import "../../firebase/firebase_options_dev.dart";
{{/has_firebase}}

void main() async {
  usePathUrlStrategy();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  
  final loggerFeatures = <Enum, bool>{
    ThemeLoggers.theme: true,
    // Add more logger features as needed
  };

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  final config = ConfigStore(
    environmentName: Flavor.development.name,
    loggerFeatures: loggerFeatures,
    showDevTools: kDebugMode && kIsWeb,
    domain: kDebugMode ? "http://localhost:8060" : DevEnv.domain,
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
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == config.environment?.name,
  );
  FlutterNativeSplash.remove();

  runApp(
    kDebugMode ? DevApp() : const MainApp(),
  );
}

class DevApp extends StatelessWidget {
  DevApp({super.key});

  final store = Managers.config;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Stack(
            children: [
              Scaffold(
                appBar: store.showDevTools ?  DevAppBar() : null,
                body: const MainApp(),
              ),
              if (store.showDevTools)
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () => store.toggleDevTools(),
                    icon: store.showDevTools
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}



// import "package:deeplinks/utils/loggers.dart";
// import "package:firebase_core/firebase_core.dart";
// import "package:firebase_crashlytics/firebase_crashlytics.dart";
// import "package:flutter/foundation.dart";
// import "package:flutter/material.dart";
// import "package:flutter/services.dart";
// import "package:flutter_mobx/flutter_mobx.dart";
// import "package:flutter_web_plugins/url_strategy.dart";
// import "package:lets_yak_app/app.dart";
// import "package:lets_yak_app/dependencies/injection.dart";
// import "package:lets_yak_app/environments/dev/components/app_bar.dart";
// import "package:lets_yak_app/environments/dev/env.dart";
// import "package:lets_yak_app/utils/loggers.dart";
// import "package:lets_yak_package/config/store.dart";
// import "package:theme/app/app.dart";

// import "../../firebase/firebase_options_dev.dart";

// void main() async {
//   usePathUrlStrategy();
//   WidgetsFlutterBinding.ensureInitialized();
//   final loggerFeatures = <Enum, bool>{
//     LetsYakAppLoggers.navigation: true,
//     DeeplinksLoggers.deeplinks: true,
//   };
//   if (!kIsWeb) {
//     await SystemChrome.setPreferredOrientations(
//       [
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ],
//     );
//   }

//   final config = ConfigStore(
//     DevEnv.name,
//     // ignore: avoid_redundant_argument_values
//     showDevTools: kDebugMode && kIsWeb,
//     loggerFeatures: loggerFeatures,
//     // overrideFeatures: kDebugMode,
//     domain: kDebugMode ? "http://localhost:8060" : DevEnv.domain,
//   );

//   //Initialize firebase project
//   await Firebase.initializeApp(
//     name: !kIsWeb ? config.environment?.name : null,
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   await Managers.init(config: config);

//   if (!kIsWeb) {
//     // Pass all uncaught "fatal" errors from the framework to Crashlytics
//     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

//     // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
//     PlatformDispatcher.instance.onError = (error, stack) {
//       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//       return true;
//     };
//   }

//   runApp(
//     kDebugMode ? DevApp() : const MainApp(),
//   );
// }

// class DevApp extends StatelessWidget {
//   DevApp({
//     super.key,
//   });

//   final store = Managers.config;

//   @override
//   Widget build(BuildContext context) {
//     return Observer(
//       builder: (context) {
//         return MaterialApp(
//           theme: AppTheme.currentTheme,
//           debugShowCheckedModeBanner: false,
//           home: Stack(
//             children: [
//               Scaffold(
//                 appBar: DevAppBar(),
//                 body: const MainApp(),
//               ),
//               if (Managers.config.showDevTools)
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: IconButton(
//                     onPressed: () => Managers.config.toggleDevTools(),
//                     icon: store.showDevTools
//                         ? const Icon(Icons.visibility_off)
//                         : const Icon(
//                             Icons.visibility,
//                           ),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
