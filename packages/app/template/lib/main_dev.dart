import 'package:app_template/app.dart';

/// FIREBASE START
// import 'package:app_template/firebase/firebase_options_dev.dart';
// import 'package:firebase_core/firebase_core.dart';

/// FIREBASE END
import 'package:flutter/widgets.dart';
import 'package:utilities/flavors/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final flavorConfig = FlavorConfig(
    environment: Environment.development,
    apiPrefix: "dev_base_url",
  );

  /// FIREBASE START
  // Initialise firebase project
  // await Firebase.initializeApp(
  //   name: flavorConfig.environment.name,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  /// FIREBASE END
  await appMain(flavorConfig: flavorConfig);
}
