part of 'forgotten_password_bloc.dart';

@freezed
class ForgottenPasswordState with _$ForgottenPasswordState {
  @formConstructor
  const factory ForgottenPasswordState({
    required FormInputModel<String> email,
    String? formError,
    @Default(BlocStatus.initial) BlocStatus status,
  }) = _ForgottenPasswordState;

  // initial state
  factory ForgottenPasswordState.initial() => ForgottenPasswordState(
        email: FormInputModel(validator: (value) => value.required()),
      );
}
