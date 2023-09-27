///THIS PAGE IS ONLY FOR DEVELOPMENT PURPOSES
/// IT IS OVERWRITTEN WHEN GENERATING THE TEMPLATE
import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';
import 'bootstrap.dart';
import 'config/_config.dart';

// flutter build -t lib/main_development.dart
void main() async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();

  await Config.instance.initialize("config/staging.json", Environment.stage);

  unawaited(bootstrap((_) => const App()));
}
