// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$AuthService extends AuthService {
  _$AuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthService;

  @override
  Future<Response<AuthResultModel>> authPost({required AuthRequestModel body}) {
    final Uri $url = Uri.parse('/auth');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AuthResultModel, AuthResultModel>($request);
  }

  @override
  Future<Response<UserModel>> registerPost({required AuthRegisterModel body}) {
    final Uri $url = Uri.parse('/register');
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
  Future<Response<Message>> forgottenPassword(
      {required ForgottenRequestModel body}) {
    final Uri $url = Uri.parse('/forgotten-password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Message, Message>($request);
  }

  @override
  Future<Response<Message>> resetPassword(
      {required ResetPasswordRequestModel body}) {
    final Uri $url = Uri.parse('/reset-password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Message, Message>($request);
  }

  @override
  Future<Response<Exists>> isUnique({
    String? email,
    String? username,
  }) {
    final Uri $url = Uri.parse('/is-unique');
    final Map<String, dynamic> $params = <String, dynamic>{
      'email': email,
      'username': username,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Exists, Exists>($request);
  }
}
