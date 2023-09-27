// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthRequestModel _$$_AuthRequestModelFromJson(Map<String, dynamic> json) =>
    _$_AuthRequestModel(
      grantType: $enumDecode(_$GrantTypeEnumMap, json['grant_type']),
      clientId: json['client_id'] as String,
      clientSecret: json['client_secret'] as String,
      username: json['username'] as String?,
      password: json['password'] as String?,
      refreshToken: json['refresh_token'] as String?,
      code: json['code'] as String?,
      redirectUri: json['redirect_uri'] as String?,
    );

Map<String, dynamic> _$$_AuthRequestModelToJson(_$_AuthRequestModel instance) =>
    <String, dynamic>{
      'grant_type': _$GrantTypeEnumMap[instance.grantType]!,
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'username': instance.username,
      'password': instance.password,
      'refresh_token': instance.refreshToken,
      'code': instance.code,
      'redirect_uri': instance.redirectUri,
    };

const _$GrantTypeEnumMap = {
  GrantType.password: 'password',
  GrantType.social: 'social',
};
