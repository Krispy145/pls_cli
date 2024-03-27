import 'package:app_template/app.dart';
import 'package:app_template/environments/config.dart';
import 'package:app_template/environments/stage/env.dart';
import 'package:flutter/widgets.dart';

/// FIREBASE START
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import '../../firebase/firebase_options_stg.dart';
/// FIREBASE END

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loggerFeatures = <Enum, bool>{
    //TODO: Add logger features here
  };

  final config = Config(
    StageEnv.name,
    key1: StageEnv.key1,
    loggerFeatures: loggerFeatures,
    apiPrefix: "dev_base_url",
  );

  /// FIREBASE START
  //TODO: Uncomment this after adding the firebase_options_stage.dart file
  // Initialize firebase project
  // await Firebase.initializeApp(
  //   name: !kIsWeb ? config.environment?.name : null,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  /// FIREBASE END
  appMain(config: config);
}
