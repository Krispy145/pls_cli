import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../_config.dart';

class SettingsRepository {
  SettingsDb db = SettingsDb(box: Hive.box<dynamic>("settings"));

  /// Listen to changes in the settings db.
  Stream<SettingsModel> get stream =>
      db.stream.map((_) => settings).asBroadcastStream();

  SettingsModel get settings {
    final settings = db.get();
    if (settings != null) return SettingsModel.fromJson(settings);

    return const SettingsModel();
  }

  void set(SettingsModel settings) {
    // ignore: unused_local_variable
    final json = jsonEncode(settings);
    db.set(jsonEncode(settings));
  }

  /// reset all settings to default values useful for logging a auth out.
  void reset() {
    db.set(jsonEncode(const SettingsModel()));
  }

  Future<void> createUserDb(String dbName) async {
    await Hive.openBox<dynamic>(dbName);
    db = SettingsDb(box: Hive.box<dynamic>(dbName));
  }
}
