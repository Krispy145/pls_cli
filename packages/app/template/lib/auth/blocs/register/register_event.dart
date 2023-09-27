part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged(this.email);
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged(this.password);
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  const RegisterConfirmPasswordChanged(this.confirmPassword);
}

class RegisterNameChanged extends RegisterEvent {
  final String name;
  const RegisterNameChanged(this.name);
}

class RegisterHasAgreedChanged extends RegisterEvent {
  final bool hasAgreed;
  //ignore: avoid_positional_boolean_parameters
  const RegisterHasAgreedChanged(this.hasAgreed);
}

class RegisterSubmitted extends RegisterEvent {}
