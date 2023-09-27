// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_result.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthResultModel _$$_AuthResultModelFromJson(Map<String, dynamic> json) =>
    _$_AuthResultModel(
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$$_AuthResultModelToJson(_$_AuthResultModel instance) =>
    <String, dynamic>{
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
