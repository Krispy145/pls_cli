// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgotten_password_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ForgottenPasswordState {
  FormInputModel<String> get email => throw _privateConstructorUsedError;
  String? get formError => throw _privateConstructorUsedError;
  BlocStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ForgottenPasswordStateCopyWith<ForgottenPasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgottenPasswordStateCopyWith<$Res> {
  factory $ForgottenPasswordStateCopyWith(ForgottenPasswordState value,
          $Res Function(ForgottenPasswordState) then) =
      _$ForgottenPasswordStateCopyWithImpl<$Res, ForgottenPasswordState>;
  @useResult
  $Res call(
      {FormInputModel<String> email, String? formError, BlocStatus status});

  $FormInputModelCopyWith<String, $Res> get email;
}

/// @nodoc
class _$ForgottenPasswordStateCopyWithImpl<$Res,
        $Val extends ForgottenPasswordState>
    implements $ForgottenPasswordStateCopyWith<$Res> {
  _$ForgottenPasswordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? formError = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
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
  $FormInputModelCopyWith<String, $Res> get email {
    return $FormInputModelCopyWith<String, $Res>(_value.email, (value) {
      return _then(_value.copyWith(email: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ForgottenPasswordStateCopyWith<$Res>
    implements $ForgottenPasswordStateCopyWith<$Res> {
  factory _$$_ForgottenPasswordStateCopyWith(_$_ForgottenPasswordState value,
          $Res Function(_$_ForgottenPasswordState) then) =
      __$$_ForgottenPasswordStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FormInputModel<String> email, String? formError, BlocStatus status});

  @override
  $FormInputModelCopyWith<String, $Res> get email;
}

/// @nodoc
class __$$_ForgottenPasswordStateCopyWithImpl<$Res>
    extends _$ForgottenPasswordStateCopyWithImpl<$Res,
        _$_ForgottenPasswordState>
    implements _$$_ForgottenPasswordStateCopyWith<$Res> {
  __$$_ForgottenPasswordStateCopyWithImpl(_$_ForgottenPasswordState _value,
      $Res Function(_$_ForgottenPasswordState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? formError = freezed,
    Object? status = null,
  }) {
    return _then(_$_ForgottenPasswordState(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
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
class _$_ForgottenPasswordState implements _ForgottenPasswordState {
  const _$_ForgottenPasswordState(
      {required this.email, this.formError, this.status = BlocStatus.initial});

  @override
  final FormInputModel<String> email;
  @override
  final String? formError;
  @override
  @JsonKey()
  final BlocStatus status;

  @override
  String toString() {
    return 'ForgottenPasswordState(email: $email, formError: $formError, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ForgottenPasswordState &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.formError, formError) ||
                other.formError == formError) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, formError, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ForgottenPasswordStateCopyWith<_$_ForgottenPasswordState> get copyWith =>
      __$$_ForgottenPasswordStateCopyWithImpl<_$_ForgottenPasswordState>(
          this, _$identity);
}

abstract class _ForgottenPasswordState implements ForgottenPasswordState {
  const factory _ForgottenPasswordState(
      {required final FormInputModel<String> email,
      final String? formError,
      final BlocStatus status}) = _$_ForgottenPasswordState;

  @override
  FormInputModel<String> get email;
  @override
  String? get formError;
  @override
  BlocStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_ForgottenPasswordStateCopyWith<_$_ForgottenPasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}
