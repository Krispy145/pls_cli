// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgotten_password_bloc.dart';

// **************************************************************************
// Generator: BlocFormsGenerator<Freezed>
// **************************************************************************

extension ForgottenPasswordStateWithValidation on ForgottenPasswordState {
  /// List of all the FormInputs in the model
  List<FormInputModel<dynamic>> get inputs => [
        email,
      ];

  /// Checks all inputs for errors
  bool get isValid => inputs.every((element) => element.error == null);

  ForgottenPasswordState setAllInputsDirty() {
    return this.copyWith(
      email: email.setDirty(),
    );
  }
}
