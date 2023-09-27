// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'role.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoleModel _$RoleModelFromJson(Map<String, dynamic> json) {
  return _RoleModel.fromJson(json);
}

/// @nodoc
mixin _$RoleModel {
  String get roleId => throw _privateConstructorUsedError;

  /// The name of the role
  String get name => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoleModelCopyWith<RoleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoleModelCopyWith<$Res> {
  factory $RoleModelCopyWith(RoleModel value, $Res Function(RoleModel) then) =
      _$RoleModelCopyWithImpl<$Res, RoleModel>;
  @useResult
  $Res call({String roleId, String name, String? createdAt, String? updatedAt});
}

/// @nodoc
class _$RoleModelCopyWithImpl<$Res, $Val extends RoleModel>
    implements $RoleModelCopyWith<$Res> {
  _$RoleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roleId = null,
    Object? name = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoleModelCopyWith<$Res> implements $RoleModelCopyWith<$Res> {
  factory _$$_RoleModelCopyWith(
          _$_RoleModel value, $Res Function(_$_RoleModel) then) =
      __$$_RoleModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String roleId, String name, String? createdAt, String? updatedAt});
}

/// @nodoc
class __$$_RoleModelCopyWithImpl<$Res>
    extends _$RoleModelCopyWithImpl<$Res, _$_RoleModel>
    implements _$$_RoleModelCopyWith<$Res> {
  __$$_RoleModelCopyWithImpl(
      _$_RoleModel _value, $Res Function(_$_RoleModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roleId = null,
    Object? name = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_RoleModel(
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RoleModel implements _RoleModel {
  const _$_RoleModel(
      {required this.roleId,
      required this.name,
      this.createdAt,
      this.updatedAt});

  factory _$_RoleModel.fromJson(Map<String, dynamic> json) =>
      _$$_RoleModelFromJson(json);

  @override
  final String roleId;

  /// The name of the role
  @override
  final String name;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'RoleModel(roleId: $roleId, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoleModel &&
            (identical(other.roleId, roleId) || other.roleId == roleId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, roleId, name, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoleModelCopyWith<_$_RoleModel> get copyWith =>
      __$$_RoleModelCopyWithImpl<_$_RoleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoleModelToJson(
      this,
    );
  }
}

abstract class _RoleModel implements RoleModel {
  const factory _RoleModel(
      {required final String roleId,
      required final String name,
      final String? createdAt,
      final String? updatedAt}) = _$_RoleModel;

  factory _RoleModel.fromJson(Map<String, dynamic> json) =
      _$_RoleModel.fromJson;

  @override
  String get roleId;
  @override

  /// The name of the role
  String get name;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_RoleModelCopyWith<_$_RoleModel> get copyWith =>
      throw _privateConstructorUsedError;
}
