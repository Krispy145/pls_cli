import 'package:freezed_annotation/freezed_annotation.dart';

import '../_models.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String firstName,
    required String email,
    @Default(true) bool termsAndConditions,
    @Default(<RoleModel>[]) List<RoleModel> roles,
    AvatarModel? avatar,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
