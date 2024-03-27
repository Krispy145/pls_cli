import 'package:app_template/app.dart';
import 'package:app_template/environments/config.dart';
import 'package:app_template/environments/prod/env.dart';
import 'package:flutter/widgets.dart';

/// FIREBASE START
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import '../../firebase/firebase_options_prod.dart';
/// FIREBASE END

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = Config(
    ProdEnv.name,
    key1: ProdEnv.key1,
    loggerFeatures: <Enum, bool>{},
    apiPrefix: "prod_base_url",
  );

  /// FIREBASE START
  //TODO: Uncomment this after adding the firebase_options_prod.dart file
  // Initialize firebase project
  // await Firebase.initializeApp(
  //   name: !kIsWeb ? config.environment?.name : null,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  /// FIREBASE END
  appMain(config: config);
}
