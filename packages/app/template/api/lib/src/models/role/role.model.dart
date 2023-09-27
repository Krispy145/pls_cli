import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.model.freezed.dart';

part 'role.model.g.dart';

//
// {
// "role_id": "e1e9682b-d83f-415d-a42e-5f33fcbccd9a",
// "name": "user",
// "created_at": "2022-05-20T11:58:44.000000Z",
// "updated_at": "2022-05-20T11:58:44.000000Z"
// }
@freezed
class RoleModel with _$RoleModel {
  const factory RoleModel({
    required String roleId,

    /// The name of the role
    required String name,
    String? createdAt,
    String? updatedAt,
  }) = _RoleModel;

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);
}
