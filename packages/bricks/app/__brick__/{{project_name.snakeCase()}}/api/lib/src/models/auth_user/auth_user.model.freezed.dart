// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) {
  return _AuthUserModel.fromJson(json);
}

/// @nodoc
mixin _$AuthUserModel {
  String get userId => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  List<RoleModel>? get roles => throw _privateConstructorUsedError;
  AvatarModel? get avatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthUserModelCopyWith<AuthUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserModelCopyWith<$Res> {
  factory $AuthUserModelCopyWith(
          AuthUserModel value, $Res Function(AuthUserModel) then) =
      _$AuthUserModelCopyWithImpl<$Res, AuthUserModel>;
  @useResult
  $Res call(
      {String userId,
      String? firstName,
      String email,
      List<RoleModel>? roles,
      AvatarModel? avatar});

  $AvatarModelCopyWith<$Res>? get avatar;
}

/// @nodoc
class _$AuthUserModelCopyWithImpl<$Res, $Val extends AuthUserModel>
    implements $AuthUserModelCopyWith<$Res> {
  _$AuthUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? firstName = freezed,
    Object? email = null,
    Object? roles = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      roles: freezed == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<RoleModel>?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as AvatarModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AvatarModelCopyWith<$Res>? get avatar {
    if (_value.avatar == null) {
      return null;
    }

    return $AvatarModelCopyWith<$Res>(_value.avatar!, (value) {
      return _then(_value.copyWith(avatar: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AuthUserModelCopyWith<$Res>
    implements $AuthUserModelCopyWith<$Res> {
  factory _$$_AuthUserModelCopyWith(
          _$_AuthUserModel value, $Res Function(_$_AuthUserModel) then) =
      __$$_AuthUserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String? firstName,
      String email,
      List<RoleModel>? roles,
      AvatarModel? avatar});

  @override
  $AvatarModelCopyWith<$Res>? get avatar;
}

/// @nodoc
class __$$_AuthUserModelCopyWithImpl<$Res>
    extends _$AuthUserModelCopyWithImpl<$Res, _$_AuthUserModel>
    implements _$$_AuthUserModelCopyWith<$Res> {
  __$$_AuthUserModelCopyWithImpl(
      _$_AuthUserModel _value, $Res Function(_$_AuthUserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? firstName = freezed,
    Object? email = null,
    Object? roles = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_$_AuthUserModel(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      roles: freezed == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<RoleModel>?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as AvatarModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthUserModel implements _AuthUserModel {
  const _$_AuthUserModel(
      {required this.userId,
      this.firstName,
      required this.email,
      final List<RoleModel>? roles = const <RoleModel>[],
      this.avatar})
      : _roles = roles;

  factory _$_AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$$_AuthUserModelFromJson(json);

  @override
  final String userId;
  @override
  final String? firstName;
  @override
  final String email;
  final List<RoleModel>? _roles;
  @override
  @JsonKey()
  List<RoleModel>? get roles {
    final value = _roles;
    if (value == null) return null;
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AvatarModel? avatar;

  @override
  String toString() {
    return 'AuthUserModel(userId: $userId, firstName: $firstName, email: $email, roles: $roles, avatar: $avatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthUserModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, firstName, email,
      const DeepCollectionEquality().hash(_roles), avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthUserModelCopyWith<_$_AuthUserModel> get copyWith =>
      __$$_AuthUserModelCopyWithImpl<_$_AuthUserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthUserModelToJson(
      this,
    );
  }
}

abstract class _AuthUserModel implements AuthUserModel {
  const factory _AuthUserModel(
      {required final String userId,
      final String? firstName,
      required final String email,
      final List<RoleModel>? roles,
      final AvatarModel? avatar}) = _$_AuthUserModel;

  factory _AuthUserModel.fromJson(Map<String, dynamic> json) =
      _$_AuthUserModel.fromJson;

  @override
  String get userId;
  @override
  String? get firstName;
  @override
  String get email;
  @override
  List<RoleModel>? get roles;
  @override
  AvatarModel? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$_AuthUserModelCopyWith<_$_AuthUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
