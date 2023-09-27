part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const RegisterState._();

  @formConstructor
  const factory RegisterState({
    required FormInputModel<String> name,
    required FormInputModel<String> email,
    required FormInputModel<String> password,
    required FormInputModel<String> confirmPassword,
    required FormInputModel<bool> hasAgreed,
    @Default(false) bool isLoading,
    String? formError,
  }) = _RegisterState;

  // initial state
  factory RegisterState.initial() => RegisterState(
        name: FormInputModel(
          validator: (value) =>
              value.required(message: "Please enter your name"),
        ),
        email: FormInputModel(
          validator: (value) =>
              value.required(message: "Please enter your email") ??
              value?.validateEmail(),
        ),
        password: passwordValidator,
        confirmPassword: FormInputModel(
          matchValidator: (confirmPassword, password) => (confirmPassword ?? "")
              .validateMatch(password, message: 'Passwords must match'),
        ),
        hasAgreed: FormInputModel(
          value: false,
          validator: (hasAgreed) => hasAgreed!
              ? null
              : "Agree to the terms and conditions to continue",
        ),
      );
}
