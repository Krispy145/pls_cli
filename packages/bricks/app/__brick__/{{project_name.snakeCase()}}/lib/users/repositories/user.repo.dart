import 'dart:io';

import 'package:api/api.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/_core.dart';

class UserRepository {
  final _client = locator<ClientSdk>();

  /// Stream containing the [User] to be accessed across multiple blocs/cubits.
  final _controller = BehaviorSubject<UserModel?>();
  Stream<UserModel?> get stream => _controller.stream;

  Future<UserModel> getUser(String id) async {
    final response = await _client.api.user
        .showUser(userId: id);
    _controller.add(response.body);
    return response.body!;
  }

  /// Patch User
  ///
  /// Used to updated a subset of user details without having to update the full
  /// user object.
  ///
  /// For instance; updating just the password without having to send a users
  /// first name.
  ///
  /// If no user id is supplied then the logged in users id will be used.
  ///
  /// Can update the user avatar/image by passing an image as a file. This does
  /// a separate call to the avatar endpoint.
  Future<UserModel> patchUser({
    required String userId,
    File? image,
    UserPatchModel user = const UserPatchModel(),
  }) async {
    AvatarModel? avatar;
    if (image != null) {
      final avatarRes = await _client.api.avatar.storeAvatar(image.path);
      avatar = avatarRes.body;
    }
    final response = await _client.api.user.patchUser(
      userId: userId,
      body: user.copyWith(avatar: avatar),
    );

    // remove access token to refresh token data with updated details.
    _client.token.removeAccessToken();

    // Add the new user to the user stream to update the user bloc.
    // This will make sure all user references within the application are always
    // up to date.
    _controller.add(response.body);

    return response.body!;
  }

  Future<void> close() async {
    await _controller.close();
  }
}
