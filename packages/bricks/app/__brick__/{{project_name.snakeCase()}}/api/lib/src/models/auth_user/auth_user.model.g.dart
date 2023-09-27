// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthUserModel _$$_AuthUserModelFromJson(Map<String, dynamic> json) =>
    _$_AuthUserModel(
      userId: json['user_id'] as String,
      firstName: json['first_name'] as String?,
      email: json['email'] as String,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => RoleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RoleModel>[],
      avatar: json['avatar'] == null
          ? null
          : AvatarModel.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AuthUserModelToJson(_$_AuthUserModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'email': instance.email,
      'roles': instance.roles,
      'avatar': instance.avatar,
    };
