// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$UserService extends UserService {
  _$UserService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UserService;

  @override
  Future<Response<UserModel>> storeUser({required UserCreateModel body}) {
    final Uri $url = Uri.parse('/users');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserModel, UserModel>($request);
  }

  @override
  Future<Response<UserModel>> showUser({required String? userId}) {
    final Uri $url = Uri.parse('/users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserModel, UserModel>($request);
  }

  @override
  Future<Response<UserModel>> updateUser({
    required String? userId,
    required UserCreateModel? body,
  }) {
    final Uri $url = Uri.parse('/users/${userId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserModel, UserModel>($request);
  }

  @override
  Future<Response<UserModel>> patchUser({
    required String? userId,
    required UserPatchModel? body,
  }) {
    final Uri $url = Uri.parse('/users/${userId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserModel, UserModel>($request);
  }

  @override
  Future<Response<Message>> destroyUser({required String? userId}) {
    final Uri $url = Uri.parse('/users/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<Message, Message>($request);
  }
}
