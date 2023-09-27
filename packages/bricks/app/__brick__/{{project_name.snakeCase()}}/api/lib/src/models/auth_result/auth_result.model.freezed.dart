// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_result.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthResultModel _$AuthResultModelFromJson(Map<String, dynamic> json) {
  return _AuthResultModel.fromJson(json);
}

/// @nodoc
mixin _$AuthResultModel {
  String get tokenType => throw _privateConstructorUsedError;
  int get expiresIn => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthResultModelCopyWith<AuthResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResultModelCopyWith<$Res> {
  factory $AuthResultModelCopyWith(
          AuthResultModel value, $Res Function(AuthResultModel) then) =
      _$AuthResultModelCopyWithImpl<$Res, AuthResultModel>;
  @useResult
  $Res call(
      {String tokenType,
      int expiresIn,
      String accessToken,
      String refreshToken});
}

/// @nodoc
class _$AuthResultModelCopyWithImpl<$Res, $Val extends AuthResultModel>
    implements $AuthResultModelCopyWith<$Res> {
  _$AuthResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenType = null,
    Object? expiresIn = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_value.copyWith(
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthResultModelCopyWith<$Res>
    implements $AuthResultModelCopyWith<$Res> {
  factory _$$_AuthResultModelCopyWith(
          _$_AuthResultModel value, $Res Function(_$_AuthResultModel) then) =
      __$$_AuthResultModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tokenType,
      int expiresIn,
      String accessToken,
      String refreshToken});
}

/// @nodoc
class __$$_AuthResultModelCopyWithImpl<$Res>
    extends _$AuthResultModelCopyWithImpl<$Res, _$_AuthResultModel>
    implements _$$_AuthResultModelCopyWith<$Res> {
  __$$_AuthResultModelCopyWithImpl(
      _$_AuthResultModel _value, $Res Function(_$_AuthResultModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenType = null,
    Object? expiresIn = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_$_AuthResultModel(
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthResultModel implements _AuthResultModel {
  const _$_AuthResultModel(
      {required this.tokenType,
      required this.expiresIn,
      required this.accessToken,
      required this.refreshToken});

  factory _$_AuthResultModel.fromJson(Map<String, dynamic> json) =>
      _$$_AuthResultModelFromJson(json);

  @override
  final String tokenType;
  @override
  final int expiresIn;
  @override
  final String accessToken;
  @override
  final String refreshToken;

  @override
  String toString() {
    return 'AuthResultModel(tokenType: $tokenType, expiresIn: $expiresIn, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthResultModel &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tokenType, expiresIn, accessToken, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthResultModelCopyWith<_$_AuthResultModel> get copyWith =>
      __$$_AuthResultModelCopyWithImpl<_$_AuthResultModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthResultModelToJson(
      this,
    );
  }
}

abstract class _AuthResultModel implements AuthResultModel {
  const factory _AuthResultModel(
      {required final String tokenType,
      required final int expiresIn,
      required final String accessToken,
      required final String refreshToken}) = _$_AuthResultModel;

  factory _AuthResultModel.fromJson(Map<String, dynamic> json) =
      _$_AuthResultModel.fromJson;

  @override
  String get tokenType;
  @override
  int get expiresIn;
  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$_AuthResultModelCopyWith<_$_AuthResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}
