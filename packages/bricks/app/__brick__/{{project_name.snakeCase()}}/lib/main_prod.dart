import 'package:{{project_name.snakeCase()}}/app.dart';

{{#has_firebase}}
//TODO: Uncomment this after running the firebase setup script
// import 'package:{{project_name.snakeCase()}}/firebase/firebase_options_prod.dart';
// import 'package:firebase_core/firebase_core.dart';

{{/has_firebase}}
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:utilities/flavors/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final flavorConfig = FlavorConfig(
    environment: Environment.production,
    apiPrefix: "prod_base_url",
  );

  {{#has_firebase}}
  //TODO: Uncomment this after adding the firebase_options_prod.dart file
  // Initialize firebase project
  // await Firebase.initializeApp(
  //   name: !kIsWeb ? flavorConfig.environment.name : null,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  {{/has_firebase}}
  await appMain(flavorConfig: flavorConfig);
}
