import 'dart:async';

import 'package:api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/_core.dart';
import '../../_auth.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepo = locator<AuthRepository>();
  late final StreamSubscription<AuthUserModel?> _authSubscription;

  AuthBloc() : super(const AuthState()) {
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthUpdated>(_onAuthUpdated);
    on<AuthDeleteRequested>(_onDeleteRequested);

    _authSubscription = _authRepo.stream.listen((event) {
      add(AuthUpdated(event));
    });
  }

  @override
  Future<void> close() async {
    await _authSubscription.cancel();
    return super.close();
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested _,
    Emitter<AuthState> emit,
  ) async {
    await _authRepo.logout();
    emit(state.copyWith(status: AuthStatus.unauthorised));
  }

  FutureOr<void> _onAuthCheckRequested(
    AuthCheckRequested _,
    Emitter<AuthState> __,
  ) async {
    await _authRepo.checkAuth();
  }

  FutureOr<void> _onAuthUpdated(
    AuthUpdated event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        authModel: event.authModel,
        status: event.authModel != null
            ? AuthStatus.authorised
            : AuthStatus.unauthorised,
      ),
    );
  }

  FutureOr<void> _onDeleteRequested(
    AuthDeleteRequested _,
    Emitter<AuthState> __,
  ) async {
    await _authRepo.deleteUser(state.authModel!.userId);
    add(AuthLogoutRequested());
  }
}
