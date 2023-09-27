part of 'auth_bloc.dart';

enum AuthStatus {
  authorised,
  unauthorised,
  initial,
}

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    AuthUserModel? authModel,
    @Default(AuthStatus.initial) AuthStatus status,
  }) = _AuthState;
}
