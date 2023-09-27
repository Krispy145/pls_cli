// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegisterState {
  FormInputModel<String> get name => throw _privateConstructorUsedError;
  FormInputModel<String> get email => throw _privateConstructorUsedError;
  FormInputModel<String> get password => throw _privateConstructorUsedError;
  FormInputModel<String> get confirmPassword =>
      throw _privateConstructorUsedError;
  FormInputModel<bool> get hasAgreed => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get formError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterStateCopyWith<RegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStateCopyWith<$Res> {
  factory $RegisterStateCopyWith(
          RegisterState value, $Res Function(RegisterState) then) =
      _$RegisterStateCopyWithImpl<$Res, RegisterState>;
  @useResult
  $Res call(
      {FormInputModel<String> name,
      FormInputModel<String> email,
      FormInputModel<String> password,
      FormInputModel<String> confirmPassword,
      FormInputModel<bool> hasAgreed,
      bool isLoading,
      String? formError});

  $FormInputModelCopyWith<String, $Res> get name;
  $FormInputModelCopyWith<String, $Res> get email;
  $FormInputModelCopyWith<String, $Res> get password;
  $FormInputModelCopyWith<String, $Res> get confirmPassword;
  $FormInputModelCopyWith<bool, $Res> get hasAgreed;
}

/// @nodoc
class _$RegisterStateCopyWithImpl<$Res, $Val extends RegisterState>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? hasAgreed = null,
    Object? isLoading = null,
    Object? formError = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      hasAgreed: null == hasAgreed
          ? _value.hasAgreed
          : hasAgreed // ignore: cast_nullable_to_non_nullable
              as FormInputModel<bool>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      formError: freezed == formError
          ? _value.formError
          : formError // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FormInputModelCopyWith<String, $Res> get name {
    return $FormInputModelCopyWith<String, $Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FormInputModelCopyWith<String, $Res> get email {
    return $FormInputModelCopyWith<String, $Res>(_value.email, (value) {
      return _then(_value.copyWith(email: value) as $Val);
    });
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

  @override
  @pragma('vm:prefer-inline')
  $FormInputModelCopyWith<bool, $Res> get hasAgreed {
    return $FormInputModelCopyWith<bool, $Res>(_value.hasAgreed, (value) {
      return _then(_value.copyWith(hasAgreed: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RegisterStateCopyWith<$Res>
    implements $RegisterStateCopyWith<$Res> {
  factory _$$_RegisterStateCopyWith(
          _$_RegisterState value, $Res Function(_$_RegisterState) then) =
      __$$_RegisterStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FormInputModel<String> name,
      FormInputModel<String> email,
      FormInputModel<String> password,
      FormInputModel<String> confirmPassword,
      FormInputModel<bool> hasAgreed,
      bool isLoading,
      String? formError});

  @override
  $FormInputModelCopyWith<String, $Res> get name;
  @override
  $FormInputModelCopyWith<String, $Res> get email;
  @override
  $FormInputModelCopyWith<String, $Res> get password;
  @override
  $FormInputModelCopyWith<String, $Res> get confirmPassword;
  @override
  $FormInputModelCopyWith<bool, $Res> get hasAgreed;
}

/// @nodoc
class __$$_RegisterStateCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$_RegisterState>
    implements _$$_RegisterStateCopyWith<$Res> {
  __$$_RegisterStateCopyWithImpl(
      _$_RegisterState _value, $Res Function(_$_RegisterState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? hasAgreed = null,
    Object? isLoading = null,
    Object? formError = freezed,
  }) {
    return _then(_$_RegisterState(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as FormInputModel<String>,
      hasAgreed: null == hasAgreed
          ? _value.hasAgreed
          : hasAgreed // ignore: cast_nullable_to_non_nullable
              as FormInputModel<bool>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      formError: freezed == formError
          ? _value.formError
          : formError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@formConstructor
class _$_RegisterState extends _RegisterState {
  const _$_RegisterState(
      {required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.hasAgreed,
      this.isLoading = false,
      this.formError})
      : super._();

  @override
  final FormInputModel<String> name;
  @override
  final FormInputModel<String> email;
  @override
  final FormInputModel<String> password;
  @override
  final FormInputModel<String> confirmPassword;
  @override
  final FormInputModel<bool> hasAgreed;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? formError;

  @override
  String toString() {
    return 'RegisterState(name: $name, email: $email, password: $password, confirmPassword: $confirmPassword, hasAgreed: $hasAgreed, isLoading: $isLoading, formError: $formError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.hasAgreed, hasAgreed) ||
                other.hasAgreed == hasAgreed) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.formError, formError) ||
                other.formError == formError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, email, password,
      confirmPassword, hasAgreed, isLoading, formError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegisterStateCopyWith<_$_RegisterState> get copyWith =>
      __$$_RegisterStateCopyWithImpl<_$_RegisterState>(this, _$identity);
}

abstract class _RegisterState extends RegisterState {
  const factory _RegisterState(
      {required final FormInputModel<String> name,
      required final FormInputModel<String> email,
      required final FormInputModel<String> password,
      required final FormInputModel<String> confirmPassword,
      required final FormInputModel<bool> hasAgreed,
      final bool isLoading,
      final String? formError}) = _$_RegisterState;
  const _RegisterState._() : super._();

  @override
  FormInputModel<String> get name;
  @override
  FormInputModel<String> get email;
  @override
  FormInputModel<String> get password;
  @override
  FormInputModel<String> get confirmPassword;
  @override
  FormInputModel<bool> get hasAgreed;
  @override
  bool get isLoading;
  @override
  String? get formError;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterStateCopyWith<_$_RegisterState> get copyWith =>
      throw _privateConstructorUsedError;
}
