// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_register.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthRegisterModel _$$_AuthRegisterModelFromJson(Map<String, dynamic> json) =>
    _$_AuthRegisterModel(
      firstName: json['first_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
      termsAndConditions: json['terms_and_conditions'] as bool? ?? true,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => RoleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RoleModel>[],
      avatar: json['avatar'] == null
          ? null
          : AvatarModel.fromJson(json['avatar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AuthRegisterModelToJson(
        _$_AuthRegisterModel instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'terms_and_conditions': instance.termsAndConditions,
      'roles': instance.roles,
      'avatar': instance.avatar,
    };
