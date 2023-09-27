// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MediaModel _$$_MediaModelFromJson(Map<String, dynamic> json) =>
    _$_MediaModel(
      id: json['id'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      mimeType: json['mimeType'] as String,
      handlerKey: json['handlerKey'] as String?,
      remoteIdentifier: json['remoteIdentifier'] as String?,
      extension: json['extension'] as String?,
      remotePath: json['remotePath'] as String,
    );

Map<String, dynamic> _$$_MediaModelToJson(_$_MediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'mimeType': instance.mimeType,
      'handlerKey': instance.handlerKey,
      'remoteIdentifier': instance.remoteIdentifier,
      'extension': instance.extension,
      'remotePath': instance.remotePath,
    };
