part of 'reset_password_bloc.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const ResetPasswordState._();

  @formConstructor
  const factory ResetPasswordState({
    required FormInputModel<String> password,
    required FormInputModel<String> confirmPassword,
    String? formError,
    @Default(BlocStatus.initial) BlocStatus status,
  }) = _ResetPasswordState;

  factory ResetPasswordState.initial() => ResetPasswordState(
        password: passwordValidator,
        confirmPassword: FormInputModel(
          matchValidator: (confirmPassword, password) =>
              (confirmPassword ?? "").validateMatch(
            password,
            message: 'Passwords must match',
          ),
        ),
      );
}
