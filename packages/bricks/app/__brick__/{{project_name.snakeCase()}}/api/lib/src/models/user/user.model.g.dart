// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      userId: json['user_id'] as String,
      firstName: json['first_name'] as String,
      email: json['email'] as String,
      termsAndConditions: json['terms_and_conditions'] as bool? ?? true,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => RoleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RoleModel>[],
      avatar: json['avatar'] == null
          ? null
          : AvatarModel.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'email': instance.email,
      'terms_and_conditions': instance.termsAndConditions,
      'roles': instance.roles,
      'avatar': instance.avatar,
    };
