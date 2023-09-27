import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/_core.dart';
import '../_config.dart';

class SettingsCubit extends Cubit<SettingsModel> {
  final repo = locator<SettingsRepository>();

  SettingsCubit() : super(locator<SettingsRepository>().settings);

  FutureOr<void> createUserSettings(String userId) async {
    await repo.createUserDb("${userId}_settings");
    emit(repo.settings);
  }

  void clearSettings() {
    const newSettings = SettingsModel();
    repo.set(newSettings);
    emit(newSettings);
  }
}
