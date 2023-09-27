part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordEvent {}

class ResetPasswordChanged extends ResetPasswordEvent {
  final String password;
  ResetPasswordChanged(this.password);
}

class ResetConfirmPasswordChanged extends ResetPasswordEvent {
  final String confirmPassword;
  ResetConfirmPasswordChanged(this.confirmPassword);
}

class ResetPasswordSubmit extends ResetPasswordEvent {
  final String email;
  final String token;
  ResetPasswordSubmit({required this.email, required this.token});
}
