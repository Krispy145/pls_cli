part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AuthUpdated extends AuthEvent {
  final AuthUserModel? authModel;
  AuthUpdated(this.authModel);
}

class AuthDeleteRequested extends AuthEvent {
  AuthDeleteRequested();
}
