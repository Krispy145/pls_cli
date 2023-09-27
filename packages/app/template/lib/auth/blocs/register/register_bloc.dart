import 'dart:async';

import 'package:api/api.dart';
import 'package:bloc_forms/bloc_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/_core.dart';
import '../../_auth.dart';

part 'register_bloc.freezed.dart';
part 'register_bloc.g.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState.initial()) {
    // Email is debounced so that we can check for duplicates
    on<RegisterEmailChanged>(
      _onEmailChanged,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterSubmitted>(_onSubmit);
    on<RegisterHasAgreedChanged>(_onHasAgreedChanged);
    on<RegisterNameChanged>(_onNameChanged);
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    // Update the password and the match value on the confirm password
    emit(
      state.copyWith(
        password: state.password.copyWith(value: event.password),
        confirmPassword:
            state.confirmPassword.copyWith(matchValue: event.password),
      ),
    );
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith.email(value: event.email));
    final exists =
        await locator<AuthRepository>().isFieldDuplicate(email: event.email);
    if (exists) {
      // show error using error override so that the email does not need to
      // be dirty before the error shows. This is useful because the email error
      // can show without the rest of the form errors showing.
      emit(
        state.copyWith.email(
          errorOverride: "Email already exists.",
        ),
      );
    } else if (state.email.errorOverride != null) {
      // remove error override
      emit(state.copyWith.email(errorOverride: null));
    }
  }

  void _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith.confirmPassword(value: event.confirmPassword));
  }

  FutureOr<void> _onHasAgreedChanged(
    RegisterHasAgreedChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith.hasAgreed(value: event.hasAgreed));
  }

  FutureOr<void> _onNameChanged(
    RegisterNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith.name(value: event.name));
  }

  Future<void> _onSubmit(
    RegisterSubmitted _,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final newState = state.setAllInputsDirty().copyWith(isLoading: false);
    if (newState.isValid) {
      try {
        // the form is valid call the api
        await locator<AuthRepository>().registerWithEmail(
          user: AuthRegisterModel(
            firstName: newState.name.value!,
            email: newState.email.value!,
            password: newState.password.value!,
            passwordConfirmation: newState.password.value!,
            roles: [],
          ),
        );

        emit(newState);
      } on RegisterException catch (e) {
        emit(newState.copyWith(formError: e.message));
      } on LoginException catch (e) {
        emit(newState.copyWith(formError: e.message));
      } catch (e) {
        emit(
          newState.copyWith(
            formError: 'Error registering in, please try again later',
          ),
        );
      }
    } else {
      emit(newState);
    }
  }
}
