// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) {
  return _MediaModel.fromJson(json);
}

/// @nodoc
mixin _$MediaModel {
  int get id => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "mimeType")
  String get mimeType => throw _privateConstructorUsedError;
  @JsonKey(name: "handlerKey")
  String? get handlerKey => throw _privateConstructorUsedError;
  @JsonKey(name: "remoteIdentifier")
  String? get remoteIdentifier => throw _privateConstructorUsedError;
  String? get extension => throw _privateConstructorUsedError;
  @JsonKey(name: "remotePath")
  String get remotePath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MediaModelCopyWith<MediaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaModelCopyWith<$Res> {
  factory $MediaModelCopyWith(
          MediaModel value, $Res Function(MediaModel) then) =
      _$MediaModelCopyWithImpl<$Res, MediaModel>;
  @useResult
  $Res call(
      {int id,
      String createdAt,
      String updatedAt,
      @JsonKey(name: "mimeType") String mimeType,
      @JsonKey(name: "handlerKey") String? handlerKey,
      @JsonKey(name: "remoteIdentifier") String? remoteIdentifier,
      String? extension,
      @JsonKey(name: "remotePath") String remotePath});
}

/// @nodoc
class _$MediaModelCopyWithImpl<$Res, $Val extends MediaModel>
    implements $MediaModelCopyWith<$Res> {
  _$MediaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? mimeType = null,
    Object? handlerKey = freezed,
    Object? remoteIdentifier = freezed,
    Object? extension = freezed,
    Object? remotePath = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      handlerKey: freezed == handlerKey
          ? _value.handlerKey
          : handlerKey // ignore: cast_nullable_to_non_nullable
              as String?,
      remoteIdentifier: freezed == remoteIdentifier
          ? _value.remoteIdentifier
          : remoteIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      extension: freezed == extension
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as String?,
      remotePath: null == remotePath
          ? _value.remotePath
          : remotePath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MediaModelCopyWith<$Res>
    implements $MediaModelCopyWith<$Res> {
  factory _$$_MediaModelCopyWith(
          _$_MediaModel value, $Res Function(_$_MediaModel) then) =
      __$$_MediaModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String createdAt,
      String updatedAt,
      @JsonKey(name: "mimeType") String mimeType,
      @JsonKey(name: "handlerKey") String? handlerKey,
      @JsonKey(name: "remoteIdentifier") String? remoteIdentifier,
      String? extension,
      @JsonKey(name: "remotePath") String remotePath});
}

/// @nodoc
class __$$_MediaModelCopyWithImpl<$Res>
    extends _$MediaModelCopyWithImpl<$Res, _$_MediaModel>
    implements _$$_MediaModelCopyWith<$Res> {
  __$$_MediaModelCopyWithImpl(
      _$_MediaModel _value, $Res Function(_$_MediaModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? mimeType = null,
    Object? handlerKey = freezed,
    Object? remoteIdentifier = freezed,
    Object? extension = freezed,
    Object? remotePath = null,
  }) {
    return _then(_$_MediaModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      handlerKey: freezed == handlerKey
          ? _value.handlerKey
          : handlerKey // ignore: cast_nullable_to_non_nullable
              as String?,
      remoteIdentifier: freezed == remoteIdentifier
          ? _value.remoteIdentifier
          : remoteIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      extension: freezed == extension
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as String?,
      remotePath: null == remotePath
          ? _value.remotePath
          : remotePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MediaModel implements _MediaModel {
  const _$_MediaModel(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      @JsonKey(name: "mimeType") required this.mimeType,
      @JsonKey(name: "handlerKey") this.handlerKey,
      @JsonKey(name: "remoteIdentifier") this.remoteIdentifier,
      this.extension,
      @JsonKey(name: "remotePath") required this.remotePath});

  factory _$_MediaModel.fromJson(Map<String, dynamic> json) =>
      _$$_MediaModelFromJson(json);

  @override
  final int id;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  @JsonKey(name: "mimeType")
  final String mimeType;
  @override
  @JsonKey(name: "handlerKey")
  final String? handlerKey;
  @override
  @JsonKey(name: "remoteIdentifier")
  final String? remoteIdentifier;
  @override
  final String? extension;
  @override
  @JsonKey(name: "remotePath")
  final String remotePath;

  @override
  String toString() {
    return 'MediaModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, mimeType: $mimeType, handlerKey: $handlerKey, remoteIdentifier: $remoteIdentifier, extension: $extension, remotePath: $remotePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MediaModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.handlerKey, handlerKey) ||
                other.handlerKey == handlerKey) &&
            (identical(other.remoteIdentifier, remoteIdentifier) ||
                other.remoteIdentifier == remoteIdentifier) &&
            (identical(other.extension, extension) ||
                other.extension == extension) &&
            (identical(other.remotePath, remotePath) ||
                other.remotePath == remotePath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      mimeType, handlerKey, remoteIdentifier, extension, remotePath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MediaModelCopyWith<_$_MediaModel> get copyWith =>
      __$$_MediaModelCopyWithImpl<_$_MediaModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MediaModelToJson(
      this,
    );
  }
}

abstract class _MediaModel implements MediaModel {
  const factory _MediaModel(
          {required final int id,
          required final String createdAt,
          required final String updatedAt,
          @JsonKey(name: "mimeType") required final String mimeType,
          @JsonKey(name: "handlerKey") final String? handlerKey,
          @JsonKey(name: "remoteIdentifier") final String? remoteIdentifier,
          final String? extension,
          @JsonKey(name: "remotePath") required final String remotePath}) =
      _$_MediaModel;

  factory _MediaModel.fromJson(Map<String, dynamic> json) =
      _$_MediaModel.fromJson;

  @override
  int get id;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  @JsonKey(name: "mimeType")
  String get mimeType;
  @override
  @JsonKey(name: "handlerKey")
  String? get handlerKey;
  @override
  @JsonKey(name: "remoteIdentifier")
  String? get remoteIdentifier;
  @override
  String? get extension;
  @override
  @JsonKey(name: "remotePath")
  String get remotePath;
  @override
  @JsonKey(ignore: true)
  _$$_MediaModelCopyWith<_$_MediaModel> get copyWith =>
      throw _privateConstructorUsedError;
}
