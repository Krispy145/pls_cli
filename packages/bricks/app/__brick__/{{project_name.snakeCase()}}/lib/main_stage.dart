import 'package:{{project_name.snakeCase()}}/app.dart';

{{#has_firebase}}
// import 'package:{{project_name.snakeCase()}}/firebase/firebase_options_stage.dart';
// import 'package:firebase_core/firebase_core.dart';

{{/has_firebase}}
import 'package:flutter/widgets.dart';
import 'package:utilities/flavors/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final flavorConfig = FlavorConfig(
    environment: Environment.staging,
    apiPrefix: "stage_base_url",
  );

  {{#has_firebase}}
  // Initialize firebase project
  await Firebase.initializeApp(
    name: flavorConfig.environment.name,
    options: DefaultFirebaseOptions.currentPlatform,
  );

  {{/has_firebase}}
  await appMain(flavorConfig: flavorConfig);
}
