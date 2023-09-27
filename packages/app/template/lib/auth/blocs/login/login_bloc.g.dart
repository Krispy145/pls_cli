// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_bloc.dart';

// **************************************************************************
// Generator: BlocFormsGenerator<Freezed>
// **************************************************************************

extension LoginStateWithValidation on LoginState {
  /// List of all the FormInputs in the model
  List<FormInputModel<dynamic>> get inputs => [
        email,
        password,
      ];

  /// Checks all inputs for errors
  bool get isValid => inputs.every((element) => element.error == null);

  LoginState setAllInputsDirty() {
    return this.copyWith(
      email: email.setDirty(),
      password: password.setDirty(),
    );
  }
}
