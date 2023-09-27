// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ResetPasswordState {
  FormInputModel<String> get password => throw _privateConstructorUsedError;
  FormInputModel<String> get confirmPassword =>
      throw _privateConstructorUsedError;
  String? get formError => throw _privateConstructorUsedError;
  BlocStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResetPasswordStateCopyWith<ResetPasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordStateCopyWith<$Res> {
  factory $ResetPasswordStateCopyWith(
          ResetPasswordState value, $Res Function(ResetPasswordState) then) =
      _$ResetPasswordStateCopyWithImpl<$Res, ResetPasswordState>;
  @useResult
  $Res call(
      {FormInputModel<String> password,
      FormInputModel<String> confirmPassword,
      String? formError,
      BlocStatus status});

  $FormInputModelCopyWith<String, $Res> get password;
  $FormInputModelCopyWith<String, $Res> get confirmPassword;
}

/// @nodoc
class _$ResetPasswordStateCopyWithImpl<$Res, $Val extends ResetPasswordState>
    implements $ResetPasswordStateCopyWith<$Res> {
  _$ResetPasswordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
    Object? confirmPassword = null,
    Object? formError = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      formError: freezed == formError
          ? _value.formError
          : formError // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FormInputModelCopyWith<String, $Res> get password {
    return $FormInputModelCopyWith<String, $Res>(_value.password, (value) {
      return _then(_value.copyWith(password: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FormInputModelCopyWith<String, $Res> get confirmPassword {
    return $FormInputModelCopyWith<String, $Res>(_value.confirmPassword,
        (value) {
      return _then(_value.copyWith(confirmPassword: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ResetPasswordStateCopyWith<$Res>
    implements $ResetPasswordStateCopyWith<$Res> {
  factory _$$_ResetPasswordStateCopyWith(_$_ResetPasswordState value,
          $Res Function(_$_ResetPasswordState) then) =
      __$$_ResetPasswordStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FormInputModel<String> password,
      FormInputModel<String> confirmPassword,
      String? formError,
      BlocStatus status});

  @override
  $FormInputModelCopyWith<String, $Res> get password;
  @override
  $FormInputModelCopyWith<String, $Res> get confirmPassword;
}

/// @nodoc
class __$$_ResetPasswordStateCopyWithImpl<$Res>
    extends _$ResetPasswordStateCopyWithImpl<$Res, _$_ResetPasswordState>
    implements _$$_ResetPasswordStateCopyWith<$Res> {
  __$$_ResetPasswordStateCopyWithImpl(
      _$_ResetPasswordState _value, $Res Function(_$_ResetPasswordState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
    Object? confirmPassword = null,
    Object? formError = freezed,
    Object? status = null,
  }) {
    return _then(_$_ResetPasswordState(
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      formError: freezed == formError
          ? _value.formError
          : formError // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
    ));
  }
}

/// @nodoc

@formConstructor
class _$_ResetPasswordState extends _ResetPasswordState {
  const _$_ResetPasswordState(
      {required this.password,
      required this.confirmPassword,
      this.formError,
      this.status = BlocStatus.initial})
      : super._();

  @override
  final FormInputModel<String> password;
  @override
  final FormInputModel<String> confirmPassword;
  @override
  final String? formError;
  @override
  @JsonKey()
  final BlocStatus status;

  @override
  String toString() {
    return 'ResetPasswordState(password: $password, confirmPassword: $confirmPassword, formError: $formError, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResetPasswordState &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.formError, formError) ||
                other.formError == formError) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, password, confirmPassword, formError, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResetPasswordStateCopyWith<_$_ResetPasswordState> get copyWith =>
      __$$_ResetPasswordStateCopyWithImpl<_$_ResetPasswordState>(
          this, _$identity);
}

abstract class _ResetPasswordState extends ResetPasswordState {
  const factory _ResetPasswordState(
      {required final FormInputModel<String> password,
      required final FormInputModel<String> confirmPassword,
      final String? formError,
      final BlocStatus status}) = _$_ResetPasswordState;
  const _ResetPasswordState._() : super._();

  @override
  FormInputModel<String> get password;
  @override
  FormInputModel<String> get confirmPassword;
  @override
  String? get formError;
  @override
  BlocStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_ResetPasswordStateCopyWith<_$_ResetPasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}
