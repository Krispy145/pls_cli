import 'package:api/api.dart';

part 'media_storage.service.chopper.dart';

@ChopperApi(baseUrl: "/object-storage")
abstract class MediaStorageService extends ChopperService {
  static MediaStorageService create([ChopperClient? client]) =>
      _$MediaStorageService(client);

  @Post()
  @multipart
  Future<Response<MediaModel>> store(@PartFile("file") String file);
}
