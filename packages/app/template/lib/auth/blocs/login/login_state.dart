part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const LoginState._();

  @formConstructor
  const factory LoginState({
    required FormInputModel<String> email,
    required FormInputModel<String> password,
    @Default(false) bool isLoading,
    String? formError,
  }) = _LoginState;

  factory LoginState.initial() => LoginState(
        email: FormInputModel(validator: (value) => value.required()),
        password: FormInputModel(validator: (value) => value.required()),
      );
}
