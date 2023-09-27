import 'package:freezed_annotation/freezed_annotation.dart';
import '../_models.dart';

part 'user_patch.model.freezed.dart';

part 'user_patch.model.g.dart';

@freezed
class UserPatchModel with _$UserPatchModel {
  const factory UserPatchModel({
    String? firstName,
    String? email,
    String? password,
    String? passwordConfirmation,
    @Default(true) bool termsAndConditions,
    List<RoleModel>? roles,
    AvatarModel? avatar,
  }) = _UserPatchModel;

  factory UserPatchModel.fromJson(Map<String, dynamic> json) =>
      _$UserPatchModelFromJson(json);
}
