// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaginationModel _$$_PaginationModelFromJson(Map<String, dynamic> json) =>
    _$_PaginationModel(
      pageTotal: json['page_total'] as int,
      pageCurrent: json['page_current'] as int,
      itemsPerPage: json['items_per_page'] as int,
      itemsThisPage: json['items_this_page'] as int,
      itemsTotal: json['items_total'] as int,
      nextCursor: json['next_cursor'] as String?,
      currentCursor: json['current_cursor'] as String?,
      previousCursor: json['previous_cursor'] as String?,
    );

Map<String, dynamic> _$$_PaginationModelToJson(_$_PaginationModel instance) =>
    <String, dynamic>{
      'page_total': instance.pageTotal,
      'page_current': instance.pageCurrent,
      'items_per_page': instance.itemsPerPage,
      'items_this_page': instance.itemsThisPage,
      'items_total': instance.itemsTotal,
      'next_cursor': instance.nextCursor,
      'current_cursor': instance.currentCursor,
      'previous_cursor': instance.previousCursor,
    };
