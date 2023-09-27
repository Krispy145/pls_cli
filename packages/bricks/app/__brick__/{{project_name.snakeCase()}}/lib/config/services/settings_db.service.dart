import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

class SettingsDb {
  final Box<dynamic> box;

  SettingsDb({required this.box});

  Stream<BoxEvent> get stream => box.watch();

  void set(String settingsJson) {
    box.put("settings", settingsJson);
  }

  Map<String, dynamic>? get() {
    final boxJson = box.get("settings") as String?;
    if (boxJson == null) return null;
    return jsonDecode(boxJson) as Map<String, dynamic>?;
  }
}
