import "package:api/api.dart" as api;
import 'package:bloc_forms/bloc_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/_core.dart';
import '../../_auth.dart';

part 'reset_password_bloc.freezed.dart';
part 'reset_password_bloc.g.dart';
part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordState.initial()) {
    on<ResetPasswordChanged>(_onPasswordChanged);
    on<ResetConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ResetPasswordSubmit>(_onSubmit);
  }

  void _onPasswordChanged(
    ResetPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    // Update the password and the match value on the confirm password
    emit(
      state.copyWith(
        password: state.password.copyWith(value: event.password),
        confirmPassword: state.confirmPassword.copyWith(
          matchValue: event.password,
        ),
      ),
    );
  }

  void _onConfirmPasswordChanged(
    ResetConfirmPasswordChanged event,
    Emitter<ResetPasswordState> emit,
  ) {
    // Update the password and the match value on the confirm password
    emit(state.copyWith.confirmPassword(value: event.confirmPassword));
  }

  Future<void> _onSubmit(
    ResetPasswordSubmit event,
    Emitter<ResetPasswordState> emit,
  ) async {
    final newState = state.setAllInputsDirty();
    if (newState.isValid) {
      emit(state.copyWith(status: BlocStatus.loading));
      try {
        final success = await locator<AuthRepository>().passwordReset(
          password: state.password.value!,
          token: event.token,
          email: event.email,
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
      } on api.BadRequestException {
        emit(
          state.copyWith(
            formError:
                'Unable to reset password. The token you used may have expired.',
            status: BlocStatus.error,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            formError: 'Unable to reset password, please try again later',
            status: BlocStatus.error,
          ),
        );
      }
    } else {
      emit(newState);
    }
  }
}
