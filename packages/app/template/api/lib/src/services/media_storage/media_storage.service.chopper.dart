// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_storage.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$MediaStorageService extends MediaStorageService {
  _$MediaStorageService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MediaStorageService;

  @override
  Future<Response<MediaModel>> store(String file) {
    final Uri $url = Uri.parse('/object-storage');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<String>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<MediaModel, MediaModel>($request);
  }
}
