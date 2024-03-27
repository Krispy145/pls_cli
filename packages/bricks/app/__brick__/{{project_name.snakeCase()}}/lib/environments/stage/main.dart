import 'package:{{project_name.snakeCase()}}/app.dart';
import 'package:{{project_name.snakeCase()}}/environments/config.dart';
import 'package:{{project_name.snakeCase()}}/environments/stage/env.dart';
import 'package:flutter/widgets.dart';

{{#has_firebase}}
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import '../../firebase/firebase_options_stg.dart';
{{/has_firebase}}

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

  {{#has_firebase}}
  //TODO: Uncomment this after adding the firebase_options_stage.dart file
  // Initialize firebase project
  // await Firebase.initializeApp(
  //   name: !kIsWeb ? config.environment?.name : null,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  {{/has_firebase}}
  appMain(config: config);
}
