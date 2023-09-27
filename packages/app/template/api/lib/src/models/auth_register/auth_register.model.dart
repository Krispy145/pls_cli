import 'package:freezed_annotation/freezed_annotation.dart';

import '../_models.dart';

part 'auth_register.model.freezed.dart';

part 'auth_register.model.g.dart';

@freezed
class AuthRegisterModel with _$AuthRegisterModel {
  const factory AuthRegisterModel({
    required String firstName,
    required String email,
    required String password,
    required String passwordConfirmation,
    @Default(true) bool termsAndConditions,
    @Default(<RoleModel>[]) List<RoleModel> roles,
    AvatarModel? avatar,
  }) = _AuthRegisterModel;

  factory AuthRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$AuthRegisterModelFromJson(json);
}
