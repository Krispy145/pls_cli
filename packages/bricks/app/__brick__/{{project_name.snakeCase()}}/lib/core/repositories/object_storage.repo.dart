import 'package:api/api.dart';

import '../services/setup_locator.dart';

class MediaStorageRepository {
  final _client = locator<ClientSdk>();
  Future<MediaModel> store(String filePath) async {
    final res = await _client.api.objectStorage.store(filePath);
    if (res.body == null) {
      throw "Could not store file";
    }
    return res.body!;
  }
}
