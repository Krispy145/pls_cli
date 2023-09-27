part of 'forgotten_password_bloc.dart';

@immutable
abstract class ForgottenPasswordEvent {}

class ForgottenPasswordEmailChanged extends ForgottenPasswordEvent {
  final String email;
  ForgottenPasswordEmailChanged(this.email);
}

class ForgottenPasswordSubmit extends ForgottenPasswordEvent {}
