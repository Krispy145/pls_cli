// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgotten_request.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ForgottenRequestModel _$ForgottenRequestModelFromJson(
    Map<String, dynamic> json) {
  return _ForgottenRequestModel.fromJson(json);
}

/// @nodoc
mixin _$ForgottenRequestModel {
  String get email => throw _privateConstructorUsedError;
  String get resetUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForgottenRequestModelCopyWith<ForgottenRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgottenRequestModelCopyWith<$Res> {
  factory $ForgottenRequestModelCopyWith(ForgottenRequestModel value,
          $Res Function(ForgottenRequestModel) then) =
      _$ForgottenRequestModelCopyWithImpl<$Res, ForgottenRequestModel>;
  @useResult
  $Res call({String email, String resetUrl});
}

/// @nodoc
class _$ForgottenRequestModelCopyWithImpl<$Res,
        $Val extends ForgottenRequestModel>
    implements $ForgottenRequestModelCopyWith<$Res> {
  _$ForgottenRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? resetUrl = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      resetUrl: null == resetUrl
          ? _value.resetUrl
          : resetUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ForgottenRequestModelCopyWith<$Res>
    implements $ForgottenRequestModelCopyWith<$Res> {
  factory _$$_ForgottenRequestModelCopyWith(_$_ForgottenRequestModel value,
          $Res Function(_$_ForgottenRequestModel) then) =
      __$$_ForgottenRequestModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String resetUrl});
}

/// @nodoc
class __$$_ForgottenRequestModelCopyWithImpl<$Res>
    extends _$ForgottenRequestModelCopyWithImpl<$Res, _$_ForgottenRequestModel>
    implements _$$_ForgottenRequestModelCopyWith<$Res> {
  __$$_ForgottenRequestModelCopyWithImpl(_$_ForgottenRequestModel _value,
      $Res Function(_$_ForgottenRequestModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? resetUrl = null,
  }) {
    return _then(_$_ForgottenRequestModel(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      resetUrl: null == resetUrl
          ? _value.resetUrl
          : resetUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ForgottenRequestModel implements _ForgottenRequestModel {
  const _$_ForgottenRequestModel({required this.email, required this.resetUrl});

  factory _$_ForgottenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$$_ForgottenRequestModelFromJson(json);

  @override
  final String email;
  @override
  final String resetUrl;

  @override
  String toString() {
    return 'ForgottenRequestModel(email: $email, resetUrl: $resetUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForgottenRequestModel &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.resetUrl, resetUrl) ||
                other.resetUrl == resetUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, resetUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ForgottenRequestModelCopyWith<_$_ForgottenRequestModel> get copyWith =>
      __$$_ForgottenRequestModelCopyWithImpl<_$_ForgottenRequestModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ForgottenRequestModelToJson(
      this,
    );
  }
}

abstract class _ForgottenRequestModel implements ForgottenRequestModel {
  const factory _ForgottenRequestModel(
      {required final String email,
      required final String resetUrl}) = _$_ForgottenRequestModel;

  factory _ForgottenRequestModel.fromJson(Map<String, dynamic> json) =
      _$_ForgottenRequestModel.fromJson;

  @override
  String get email;
  @override
  String get resetUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ForgottenRequestModelCopyWith<_$_ForgottenRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}
