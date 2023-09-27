import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import 'core/blocs/global_bloc_observer.dart';
import 'core/services/setup_hive.dart';
import 'core/services/setup_locator.dart';

Future<void> bootstrap(FutureOr<Widget> Function(GetIt getIt) builder) async {
  // Initialise core [GlobalBlocObserver]
  Bloc.observer = GlobalBlocObserver();

  // Initialise Hive boxes
  await setupHive();

  // Initialise application singletons
  setupLocator();

  // Initialise application logging
  _setupLogging();

  runApp(await builder(locator));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    if (kDebugMode) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    }
  });
}
