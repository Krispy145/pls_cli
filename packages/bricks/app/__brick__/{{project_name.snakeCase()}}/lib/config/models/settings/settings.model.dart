import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.model.freezed.dart';
part 'settings.model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const SettingsModel._();
  const factory SettingsModel() = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}
