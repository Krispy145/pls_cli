/// This file contains extra exceptions for managing the login flow.
///
/// The current flow is create_user > login
/// Use the exceptions in this file to tell the auth at what point the
/// registration or login failed.

/// [RegisterException] should  be thrown when the registration post request fails
class RegisterException implements Exception {
  final String message;
  const RegisterException({required this.message});
}

/// [LoginException] should  be thrown when the login post request fails
class LoginException implements Exception {
  final String message;
  const LoginException({required this.message});
}
