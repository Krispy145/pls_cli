import 'package:hive_flutter/hive_flutter.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();

  // open the settings box at the start of the app
  await Hive.openBox<dynamic>('settings');
}
