part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    UserModel? user,
    @Default(BlocStatus.initial) BlocStatus status,
  }) = _UserState;
}
