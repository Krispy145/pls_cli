import 'package:app_template/app.dart';

/// FIREBASE START
//TODO: Uncomment this after running the firebase setup script
// import 'package:app_template/firebase/firebase_options_stage.dart';
// import 'package:firebase_core/firebase_core.dart';

/// FIREBASE END
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:utilities/flavors/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loggerFeatures = <Enum, bool>{
    //TODO: Add logger features here
  };

  final flavorConfig = FlavorConfig(
    environment: Environment.staging,
    loggerFeatures: loggerFeatures,
    apiPrefix: "dev_base_url",
  );

  /// FIREBASE START
  //TODO: Uncomment this after adding the firebase_options_stage.dart file
  // Initialize firebase project
  // await Firebase.initializeApp(
  //   name: !kIsWeb ? flavorConfig.environment.name : null,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  /// FIREBASE END
  await appMain(flavorConfig: flavorConfig);
}
