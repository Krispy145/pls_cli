part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserImageAdded extends UserEvent {
  final File image;

  UserImageAdded(this.image);
}

class UserJWTUpdated extends UserEvent {
  final AuthUserModel authModel;

  UserJWTUpdated(this.authModel);
}

class UserUpdated extends UserEvent {
  final UserModel user;

  UserUpdated(this.user);
}

/// Fetch current logged in user
class UserRequested extends UserEvent {
  final String? userId;

  UserRequested({this.userId});
}

class UserAspirationUpdated extends UserEvent {
  final String text;

  UserAspirationUpdated(this.text);
}
