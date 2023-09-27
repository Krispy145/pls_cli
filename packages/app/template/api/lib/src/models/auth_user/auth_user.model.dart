import 'package:freezed_annotation/freezed_annotation.dart';

import '../_models.dart';

part 'auth_user.model.freezed.dart';

part 'auth_user.model.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String userId,
    String? firstName,
    required String email,
    @Default(<RoleModel>[]) List<RoleModel>? roles,
    AvatarModel? avatar,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
