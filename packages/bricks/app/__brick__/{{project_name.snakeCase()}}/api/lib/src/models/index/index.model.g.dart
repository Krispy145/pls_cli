// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexModel<T> _$IndexModelFromJson<T>(Map<String, dynamic> json) =>
    IndexModel<T>(
      data: (json['data'] as List<dynamic>)
          .map(_Converter<T>().fromJson)
          .toList(),
      pagination:
          PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndexModelToJson<T>(IndexModel<T> instance) =>
    <String, dynamic>{
      'pagination': instance.pagination.toJson(),
      'data': instance.data.map(_Converter<T>().toJson).toList(),
    };
