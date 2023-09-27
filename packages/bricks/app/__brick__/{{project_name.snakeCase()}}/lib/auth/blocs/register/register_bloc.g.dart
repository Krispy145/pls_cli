// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_bloc.dart';

// **************************************************************************
// Generator: BlocFormsGenerator<Freezed>
// **************************************************************************

extension RegisterStateWithValidation on RegisterState {
  /// List of all the FormInputs in the model
  List<FormInputModel<dynamic>> get inputs => [
        name,
        email,
        password,
        confirmPassword,
        hasAgreed,
      ];

  /// Checks all inputs for errors
  bool get isValid => inputs.every((element) => element.error == null);

  RegisterState setAllInputsDirty() {
    return this.copyWith(
      name: name.setDirty(),
      email: email.setDirty(),
      password: password.setDirty(),
      confirmPassword: confirmPassword.setDirty(),
      hasAgreed: hasAgreed.setDirty(),
    );
  }
}
