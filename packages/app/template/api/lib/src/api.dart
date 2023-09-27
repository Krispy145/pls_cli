import 'package:api/src/services/auth/auth.service.dart';
import 'package:api/src/services/avatar/avatar.service.dart';
import 'package:api/src/services/media_storage/media_storage.service.dart';
import 'package:api/src/services/user/user.service.dart';
import 'package:chopper/chopper.dart';

/// An api class to mirror close to what will be generated
class Api extends ChopperService {
  final AuthService auth;
  final UserService user;
  final AvatarService avatar;
  final MediaStorageService objectStorage;
  Api._({required ChopperClient client})
      : auth = AuthService.create(client),
        user = UserService.create(client),
        avatar = AvatarService.create(client),
        objectStorage = MediaStorageService.create(client) {
    super.client = client;
  }
  // Created to mirror the generation
  static Api create({required ChopperClient client}) => Api._(client: client);

  @override
  Type get definitionType => Api;
}
