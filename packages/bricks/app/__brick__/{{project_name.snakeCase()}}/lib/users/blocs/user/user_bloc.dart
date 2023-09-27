import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:api/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/_auth.dart';
import '../../../core/_core.dart';
import '../../repositories/user.repo.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _authRepo = locator<AuthRepository>();
  final _userRepo = locator<UserRepository>();
  late final StreamSubscription<UserModel?> _userSubscription;
  late final StreamSubscription<AuthUserModel?> _authSubscription;

  UserBloc() : super(const UserState()) {
    on<UserRequested>(_onUserRequested);
    on<UserJWTUpdated>(_onUserJWTUpdated);
    on<UserUpdated>(_onUserUpdated);
    on<UserImageAdded>(_onUserImageAdded);

    _authSubscription = _authRepo.stream.listen((event) {
      if (event != null) {
        add(UserJWTUpdated(event));
      }
    });

    _userSubscription = _userRepo.stream.listen((event) {
      if (event != null) {
        add(UserUpdated(event));
      }
    });
  }

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    await _authSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onUserRequested(
    UserRequested event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));
      final user = await _userRepo
          .getUser(event.userId ?? _authRepo.currentUser!.userId);
      emit(state.copyWith(user: user, status: BlocStatus.success));
    } catch (e) {
      inspect(e);
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  FutureOr<void> _onUserJWTUpdated(
    UserJWTUpdated event,
    Emitter<UserState> emit,
  ) {
    final UserModel user = UserModel(
      userId: event.authModel.userId,
      firstName: event.authModel.firstName ?? "",
      roles: event.authModel.roles ?? [],
      email: event.authModel.email,
      avatar: event.authModel.avatar,
    );
    emit(
      state.copyWith(user: user),
    );
  }

  FutureOr<void> _onUserUpdated(
    UserUpdated event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(state.copyWith(user: event.user));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  FutureOr<void> _onUserImageAdded(
    UserImageAdded event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));
      final user = await _userRepo.patchUser(
        userId: _authRepo.currentUser!.userId,
        image: event.image,
      );
      emit(state.copyWith(status: BlocStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }
}
