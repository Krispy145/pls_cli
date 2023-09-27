import 'dart:async';
import 'dart:io';

import "package:api/api.dart";
import 'package:bloc_forms/bloc_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/_core.dart';
import '../../_auth.dart';

part 'login_bloc.freezed.dart';
part 'login_bloc.g.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith.email(value: event.email));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith.password(value: event.password));
  }

  Future<void> _onSubmitted(LoginSubmitted _, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));
    final newState = state.setAllInputsDirty().copyWith(isLoading: false);
    if (newState.isValid) {
      try {
        await locator<AuthRepository>().loginWithEmail(
          email: state.email.value!,
          password: state.password.value!,
        );
        emit(newState);
      } on TokenException {
        emit(newState.copyWith(formError: 'Invalid username or password.'));
      } on SocketException {
        emit(
          newState.copyWith(
            formError:
                "Error connecting. Please check internet connection and try again",
          ),
        );
      } catch (e) {
        emit(
          newState.copyWith(
            formError: 'Error logging in, please try again later',
          ),
        );
      }
    } else {
      emit(newState);
    }
  }
}
