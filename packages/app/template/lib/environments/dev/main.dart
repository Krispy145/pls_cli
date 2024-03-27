import 'package:app_template/app.dart';
import 'package:app_template/environments/config.dart';
import 'package:app_template/environments/dev/env.dart';
import 'package:flutter/widgets.dart';

/// FIREBASE START
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import '../../firebase/firebase_options_dev.dart';
/// FIREBASE END

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loggerFeatures = <Enum, bool>{
    //TODO: Add logger features here
  };

  final config = Config(
    DevEnv.name,
    key1: DevEnv.key1,
    loggerFeatures: loggerFeatures,
    apiPrefix: "dev_base_url",
  );

  /// FIREBASE START
  // TODO: Uncomment this after adding the firebase_options_dev.dart file
  //Initialize firebase project
  // await Firebase.initializeApp(
  //   name: !kIsWeb ? config.environment?.name : null,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  /// FIREBASE END
  appMain(config: config);
}
