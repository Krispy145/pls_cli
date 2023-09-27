// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AvatarModel _$$_AvatarModelFromJson(Map<String, dynamic> json) =>
    _$_AvatarModel(
      name: json['name'] as String?,
      objectId: (json['object_id'] as num).toDouble(),
      avatarId: json['avatar_id'] as String,
    );

Map<String, dynamic> _$$_AvatarModelToJson(_$_AvatarModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'object_id': instance.objectId,
      'avatar_id': instance.avatarId,
    };
