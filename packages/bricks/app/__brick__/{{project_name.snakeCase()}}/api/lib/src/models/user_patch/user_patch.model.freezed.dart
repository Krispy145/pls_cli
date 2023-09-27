// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_patch.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserPatchModel _$UserPatchModelFromJson(Map<String, dynamic> json) {
  return _UserPatchModel.fromJson(json);
}

/// @nodoc
mixin _$UserPatchModel {
  String? get firstName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get passwordConfirmation => throw _privateConstructorUsedError;
  bool get termsAndConditions => throw _privateConstructorUsedError;
  List<RoleModel>? get roles => throw _privateConstructorUsedError;
  AvatarModel? get avatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserPatchModelCopyWith<UserPatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPatchModelCopyWith<$Res> {
  factory $UserPatchModelCopyWith(
          UserPatchModel value, $Res Function(UserPatchModel) then) =
      _$UserPatchModelCopyWithImpl<$Res, UserPatchModel>;
  @useResult
  $Res call(
      {String? firstName,
      String? email,
      String? password,
      String? passwordConfirmation,
      bool termsAndConditions,
      List<RoleModel>? roles,
      AvatarModel? avatar});

  $AvatarModelCopyWith<$Res>? get avatar;
}

/// @nodoc
class _$UserPatchModelCopyWithImpl<$Res, $Val extends UserPatchModel>
    implements $UserPatchModelCopyWith<$Res> {
  _$UserPatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? passwordConfirmation = freezed,
    Object? termsAndConditions = null,
    Object? roles = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordConfirmation: freezed == passwordConfirmation
          ? _value.passwordConfirmation
          : passwordConfirmation // ignore: cast_nullable_to_non_nullable
              as String?,
      termsAndConditions: null == termsAndConditions
          ? _value.termsAndConditions
          : termsAndConditions // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$_UserPatchModelCopyWith<$Res>
    implements $UserPatchModelCopyWith<$Res> {
  factory _$$_UserPatchModelCopyWith(
          _$_UserPatchModel value, $Res Function(_$_UserPatchModel) then) =
      __$$_UserPatchModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? firstName,
      String? email,
      String? password,
      String? passwordConfirmation,
      bool termsAndConditions,
      List<RoleModel>? roles,
      AvatarModel? avatar});

  @override
  $AvatarModelCopyWith<$Res>? get avatar;
}

/// @nodoc
class __$$_UserPatchModelCopyWithImpl<$Res>
    extends _$UserPatchModelCopyWithImpl<$Res, _$_UserPatchModel>
    implements _$$_UserPatchModelCopyWith<$Res> {
  __$$_UserPatchModelCopyWithImpl(
      _$_UserPatchModel _value, $Res Function(_$_UserPatchModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? passwordConfirmation = freezed,
    Object? termsAndConditions = null,
    Object? roles = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_$_UserPatchModel(
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      passwordConfirmation: freezed == passwordConfirmation
          ? _value.passwordConfirmation
          : passwordConfirmation // ignore: cast_nullable_to_non_nullable
              as String?,
      termsAndConditions: null == termsAndConditions
          ? _value.termsAndConditions
          : termsAndConditions // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$_UserPatchModel implements _UserPatchModel {
  const _$_UserPatchModel(
      {this.firstName,
      this.email,
      this.password,
      this.passwordConfirmation,
      this.termsAndConditions = true,
      final List<RoleModel>? roles,
      this.avatar})
      : _roles = roles;

  factory _$_UserPatchModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserPatchModelFromJson(json);

  @override
  final String? firstName;
  @override
  final String? email;
  @override
  final String? password;
  @override
  final String? passwordConfirmation;
  @override
  @JsonKey()
  final bool termsAndConditions;
  final List<RoleModel>? _roles;
  @override
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
    return 'UserPatchModel(firstName: $firstName, email: $email, password: $password, passwordConfirmation: $passwordConfirmation, termsAndConditions: $termsAndConditions, roles: $roles, avatar: $avatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserPatchModel &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.passwordConfirmation, passwordConfirmation) ||
                other.passwordConfirmation == passwordConfirmation) &&
            (identical(other.termsAndConditions, termsAndConditions) ||
                other.termsAndConditions == termsAndConditions) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      firstName,
      email,
      password,
      passwordConfirmation,
      termsAndConditions,
      const DeepCollectionEquality().hash(_roles),
      avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserPatchModelCopyWith<_$_UserPatchModel> get copyWith =>
      __$$_UserPatchModelCopyWithImpl<_$_UserPatchModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserPatchModelToJson(
      this,
    );
  }
}

abstract class _UserPatchModel implements UserPatchModel {
  const factory _UserPatchModel(
      {final String? firstName,
      final String? email,
      final String? password,
      final String? passwordConfirmation,
      final bool termsAndConditions,
      final List<RoleModel>? roles,
      final AvatarModel? avatar}) = _$_UserPatchModel;

  factory _UserPatchModel.fromJson(Map<String, dynamic> json) =
      _$_UserPatchModel.fromJson;

  @override
  String? get firstName;
  @override
  String? get email;
  @override
  String? get password;
  @override
  String? get passwordConfirmation;
  @override
  bool get termsAndConditions;
  @override
  List<RoleModel>? get roles;
  @override
  AvatarModel? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$_UserPatchModelCopyWith<_$_UserPatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}
