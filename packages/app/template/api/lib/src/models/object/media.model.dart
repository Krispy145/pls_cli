// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.model.freezed.dart';

part 'media.model.g.dart';

@freezed
class MediaModel with _$MediaModel {
  const factory MediaModel({
    required int id,
    required String createdAt,
    required String updatedAt,
    @JsonKey(name: "mimeType") required String mimeType,
    @JsonKey(name: "handlerKey") String? handlerKey,
    @JsonKey(name: "remoteIdentifier") String? remoteIdentifier,
    String? extension,
    @JsonKey(name: "remotePath") required String remotePath,
  }) = _MediaModel;

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);
}
