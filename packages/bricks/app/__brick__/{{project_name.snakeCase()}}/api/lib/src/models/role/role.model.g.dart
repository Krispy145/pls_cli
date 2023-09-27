// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoleModel _$$_RoleModelFromJson(Map<String, dynamic> json) => _$_RoleModel(
      roleId: json['role_id'] as String,
      name: json['name'] as String,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$_RoleModelToJson(_$_RoleModel instance) =>
    <String, dynamic>{
      'role_id': instance.roleId,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
