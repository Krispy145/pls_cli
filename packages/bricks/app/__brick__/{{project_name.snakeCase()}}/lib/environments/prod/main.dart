import 'package:{{project_name.snakeCase()}}/app.dart';
import 'package:{{project_name.snakeCase()}}/environments/config.dart';
import 'package:{{project_name.snakeCase()}}/environments/prod/env.dart';
import 'package:flutter/widgets.dart';

{{#has_firebase}}
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import '../../firebase/firebase_options_prod.dart';
{{/has_firebase}}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = Config(
    ProdEnv.name,
    key1: ProdEnv.key1,
    loggerFeatures: <Enum, bool>{},
    apiPrefix: "prod_base_url",
  );

  {{#has_firebase}}
  //TODO: Uncomment this after adding the firebase_options_prod.dart file
  // Initialize firebase project
  // await Firebase.initializeApp(
  //   name: !kIsWeb ? config.environment?.name : null,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  {{/has_firebase}}
  appMain(config: config);
}
