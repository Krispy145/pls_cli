import 'package:freezed_annotation/freezed_annotation.dart';

part 'avatar.model.freezed.dart';

part 'avatar.model.g.dart';

@freezed
class AvatarModel with _$AvatarModel {
  const factory AvatarModel({
    String? name,
    required double objectId,
    required String avatarId,
  }) = _AvatarModel;

  factory AvatarModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarModelFromJson(json);
}
