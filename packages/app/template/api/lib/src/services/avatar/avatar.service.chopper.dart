// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$AvatarService extends AvatarService {
  _$AvatarService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AvatarService;

  @override
  Future<Response<AvatarModel>> showAvatar(String avatarId) {
    final Uri $url = Uri.parse('/avatars/${avatarId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AvatarModel, AvatarModel>($request);
  }

  @override
  Future<Response<AvatarModel>> storeAvatar(String file) {
    final Uri $url = Uri.parse('/avatars');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<String>(
        'avatar',
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
    return client.send<AvatarModel, AvatarModel>($request);
  }
}
