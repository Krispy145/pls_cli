// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResetPasswordRequestModel _$$_ResetPasswordRequestModelFromJson(
        Map<String, dynamic> json) =>
    _$_ResetPasswordRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$$_ResetPasswordRequestModelToJson(
        _$_ResetPasswordRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'token': instance.token,
    };
