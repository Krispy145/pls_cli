import 'package:api/src/models/_models.dart';
import 'package:chopper/chopper.dart';

part 'avatar.service.chopper.dart';

@ChopperApi(baseUrl: "/avatars")
abstract class AvatarService extends ChopperService {
  static AvatarService create([ChopperClient? client]) =>
      _$AvatarService(client);

  /// Get a single avatar by id.
  @Get(path: "/{id}")
  Future<Response<AvatarModel>> showAvatar(@Path("id") String avatarId);

  /// Create an avatar.
  @Post()
  @multipart
  Future<Response<AvatarModel>> storeAvatar(
    @PartFile("avatar") String file,
  );
}
