import 'package:freezed_annotation/freezed_annotation.dart';

import '../_models.dart';

part 'user_create.model.freezed.dart';

part 'user_create.model.g.dart';

@freezed
class UserCreateModel with _$UserCreateModel {
  const factory UserCreateModel({
    required String firstName,
    required String email,
    required String password,
    required String passwordConfirmation,
    @Default(true) bool termsAndConditions,
    List<RoleModel>? roles,
    AvatarModel? avatar,
  }) = _UserCreateModel;

  factory UserCreateModel.fromJson(Map<String, dynamic> json) =>
      _$UserCreateModelFromJson(json);
}
