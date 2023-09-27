// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_request.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthRequestModel _$AuthRequestModelFromJson(Map<String, dynamic> json) {
  return _AuthRequestModel.fromJson(json);
}

/// @nodoc
mixin _$AuthRequestModel {
  GrantType get grantType => throw _privateConstructorUsedError;
  String get clientId => throw _privateConstructorUsedError;
  String get clientSecret => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get redirectUri => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthRequestModelCopyWith<AuthRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthRequestModelCopyWith<$Res> {
  factory $AuthRequestModelCopyWith(
          AuthRequestModel value, $Res Function(AuthRequestModel) then) =
      _$AuthRequestModelCopyWithImpl<$Res, AuthRequestModel>;
  @useResult
  $Res call(
      {GrantType grantType,
      String clientId,
      String clientSecret,
      String? username,
      String? password,
      String? refreshToken,
      String? code,
      String? redirectUri});
}

/// @nodoc
class _$AuthRequestModelCopyWithImpl<$Res, $Val extends AuthRequestModel>
    implements $AuthRequestModelCopyWith<$Res> {
  _$AuthRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grantType = null,
    Object? clientId = null,
    Object? clientSecret = null,
    Object? username = freezed,
    Object? password = freezed,
    Object? refreshToken = freezed,
    Object? code = freezed,
    Object? redirectUri = freezed,
  }) {
    return _then(_value.copyWith(
      grantType: null == grantType
          ? _value.grantType
          : grantType // ignore: cast_nullable_to_non_nullable
              as GrantType,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: null == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      redirectUri: freezed == redirectUri
          ? _value.redirectUri
          : redirectUri // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthRequestModelCopyWith<$Res>
    implements $AuthRequestModelCopyWith<$Res> {
  factory _$$_AuthRequestModelCopyWith(
          _$_AuthRequestModel value, $Res Function(_$_AuthRequestModel) then) =
      __$$_AuthRequestModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GrantType grantType,
      String clientId,
      String clientSecret,
      String? username,
      String? password,
      String? refreshToken,
      String? code,
      String? redirectUri});
}

/// @nodoc
class __$$_AuthRequestModelCopyWithImpl<$Res>
    extends _$AuthRequestModelCopyWithImpl<$Res, _$_AuthRequestModel>
    implements _$$_AuthRequestModelCopyWith<$Res> {
  __$$_AuthRequestModelCopyWithImpl(
      _$_AuthRequestModel _value, $Res Function(_$_AuthRequestModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grantType = null,
    Object? clientId = null,
    Object? clientSecret = null,
    Object? username = freezed,
    Object? password = freezed,
    Object? refreshToken = freezed,
    Object? code = freezed,
    Object? redirectUri = freezed,
  }) {
    return _then(_$_AuthRequestModel(
      grantType: null == grantType
          ? _value.grantType
          : grantType // ignore: cast_nullable_to_non_nullable
              as GrantType,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: null == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      redirectUri: freezed == redirectUri
          ? _value.redirectUri
          : redirectUri // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthRequestModel implements _AuthRequestModel {
  const _$_AuthRequestModel(
      {required this.grantType,
      required this.clientId,
      required this.clientSecret,
      this.username,
      this.password,
      this.refreshToken,
      this.code,
      this.redirectUri});

  factory _$_AuthRequestModel.fromJson(Map<String, dynamic> json) =>
      _$$_AuthRequestModelFromJson(json);

  @override
  final GrantType grantType;
  @override
  final String clientId;
  @override
  final String clientSecret;
  @override
  final String? username;
  @override
  final String? password;
  @override
  final String? refreshToken;
  @override
  final String? code;
  @override
  final String? redirectUri;

  @override
  String toString() {
    return 'AuthRequestModel(grantType: $grantType, clientId: $clientId, clientSecret: $clientSecret, username: $username, password: $password, refreshToken: $refreshToken, code: $code, redirectUri: $redirectUri)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthRequestModel &&
            (identical(other.grantType, grantType) ||
                other.grantType == grantType) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientSecret, clientSecret) ||
                other.clientSecret == clientSecret) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.redirectUri, redirectUri) ||
                other.redirectUri == redirectUri));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, grantType, clientId,
      clientSecret, username, password, refreshToken, code, redirectUri);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthRequestModelCopyWith<_$_AuthRequestModel> get copyWith =>
      __$$_AuthRequestModelCopyWithImpl<_$_AuthRequestModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthRequestModelToJson(
      this,
    );
  }
}

abstract class _AuthRequestModel implements AuthRequestModel {
  const factory _AuthRequestModel(
      {required final GrantType grantType,
      required final String clientId,
      required final String clientSecret,
      final String? username,
      final String? password,
      final String? refreshToken,
      final String? code,
      final String? redirectUri}) = _$_AuthRequestModel;

  factory _AuthRequestModel.fromJson(Map<String, dynamic> json) =
      _$_AuthRequestModel.fromJson;

  @override
  GrantType get grantType;
  @override
  String get clientId;
  @override
  String get clientSecret;
  @override
  String? get username;
  @override
  String? get password;
  @override
  String? get refreshToken;
  @override
  String? get code;
  @override
  String? get redirectUri;
  @override
  @JsonKey(ignore: true)
  _$$_AuthRequestModelCopyWith<_$_AuthRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}
