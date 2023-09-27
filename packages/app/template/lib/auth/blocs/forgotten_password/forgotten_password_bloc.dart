import 'dart:async';

import "package:api/api.dart" as api;
import 'package:bloc_forms/bloc_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/_core.dart';
import '../../_auth.dart';

part 'forgotten_password_bloc.freezed.dart';
part 'forgotten_password_bloc.g.dart';
part 'forgotten_password_event.dart';
part 'forgotten_password_state.dart';

class ForgottenPasswordBloc
    extends Bloc<ForgottenPasswordEvent, ForgottenPasswordState> {
  ForgottenPasswordBloc() : super(ForgottenPasswordState.initial()) {
    on<ForgottenPasswordEmailChanged>(_onEmailChanged);
    on<ForgottenPasswordSubmit>(_onSubmit);
  }

  FutureOr<void> _onEmailChanged(
    ForgottenPasswordEmailChanged event,
    Emitter<ForgottenPasswordState> emit,
  ) {
    emit(state.copyWith.email(value: event.email));
  }

  Future<void> _onSubmit(
    ForgottenPasswordSubmit _,
    Emitter<ForgottenPasswordState> emit,
  ) async {
    final newState = state.setAllInputsDirty();
    if (newState.isValid) {
      emit(state.copyWith(status: BlocStatus.loading));
      try {
        final success = await locator<AuthRepository>().forgottenPassword(
          state.email.value!,
        );

        if (success) {
          emit(state.copyWith(status: BlocStatus.success));
        } else {
          emit(
            state.copyWith(
              status: BlocStatus.error,
              formError: 'Unable to reset password, please try again later',
            ),
          );
        }
      } on api.TokenException {
        emit(
          state.copyWith(
            formError:
                'Unable to send forgotten password request, please try again later',
            status: BlocStatus.error,
          ),
        );
      }
    } else {
      emit(newState);
    }
  }
}
