//FIREBASE START
import 'package:firebase_core/firebase_core.dart';
//FIREBASE END
import 'package:flutter/widgets.dart';
import 'package:flutter_template/app.dart';
//FIREBASE START
import 'package:flutter_template/firebase/firebase_options_production.dart';
//FIREBASE END
import 'package:utilities/flavors/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final flavorConfig = FlavorConfig(
    environment: Environment.production,
    apiPrefix: "",
  );

  //FIREBASE START
  // Initialise firebase project
  await Firebase.initializeApp(
    name: flavorConfig.environment.name,
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FIREBASE END
  appMain(flavorConfig: flavorConfig);
}
