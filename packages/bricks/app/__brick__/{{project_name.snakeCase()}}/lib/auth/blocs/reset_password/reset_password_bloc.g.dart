// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_bloc.dart';

// **************************************************************************
// Generator: BlocFormsGenerator<Freezed>
// **************************************************************************

extension ResetPasswordStateWithValidation on ResetPasswordState {
  /// List of all the FormInputs in the model
  List<FormInputModel<dynamic>> get inputs => [
        password,
        confirmPassword,
      ];

  /// Checks all inputs for errors
  bool get isValid => inputs.every((element) => element.error == null);

  ResetPasswordState setAllInputsDirty() {
    return this.copyWith(
      password: password.setDirty(),
      confirmPassword: confirmPassword.setDirty(),
    );
  }
}
