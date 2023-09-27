// export 'src/generated/api.models.swagger.dart';
// export 'src/generated/api.enums.swagger.dart';

import 'dart:convert';

import 'package:api/src/api.dart';
import 'package:api/src/json_factories.dart';
import 'package:api/src/services/auth/auth.service.dart';
import 'package:api/src/services/avatar/avatar.service.dart';
import 'package:api/src/type_parser.dart';
import 'package:client_api/client_api.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_dev_overlay/flutter_dev_overlay.dart';

// import "src/generated/api.swagger.dart";

import 'src/services/user/user.service.dart';

export 'package:client_api/client_api.dart';
export 'package:chopper/chopper.dart';

export 'src/models/_models.dart';

class ApplicationConvertor extends JsonConverter {
  final CustomJsonDecoder decoder = CustomJsonDecoder(factories: factories);

  @override
  Request convertRequest(Request request) {
    // If the request comes through a second time after the authenticator or anything
    // do nothing as it is already converted.
    if (request.body is String) return request;
    final req = super.convertRequest(request);
    if (request.method == HttpMethod.Patch && req.body != null) {
      final String bodyString = req.body as String;
      final body = (jsonDecode(bodyString) as Map<String, dynamic>)
        ..removeWhere((key, dynamic value) => value == null)
        ..removeWhere((key, dynamic value) => value is List && value.isEmpty);
      return req.copyWith(body: jsonEncode(body));
    }
    return req;
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return Response(response.base, null, error: response.error);
    }

    // final jsonRes = super.convertResponse<BodyType, InnerType>(response);
    final dynamic jsonRes = json.decode(response.body as String);
    return response.copyWith<BodyType>(
      body: decoder.decode<BodyType, InnerType>(jsonRes),
    );
  }
}

/// {@template clientSdk}
/// A wrapper around the generated api.
///
/// Adds the default interceptors to deal with re-auth flow and throw standard
/// exceptions
///
/// Calls [onLogout] when a client's access token cannot be refreshed.
/// {@endtemplate}
class ClientSdk {
  final Api api;
  final TokenService token = TokenService.instance;

  /// {@macro clientSdk}
  ClientSdk({
    bool isDev = false,
    required String baseUrl,
    required String clientId,
    required String clientSecret,
    Iterable<dynamic>? interceptors,
  }) : api = Api.create(
          client: ChopperClient(
            baseUrl: Uri.parse(baseUrl),
            services: [
              UserService.create(),
              AvatarService.create(),
              AuthService.create(),
            ],
            interceptors: <dynamic>[
              if (isDev) ...[
                CurlInterceptor(),
                HttpLoggingInterceptor(),
                OverlayLoggingInterceptor()
              ],
              AuthRequestInterceptor(),
              ApiExceptionInterceptor(),
            ],
            converter: ApplicationConvertor(),
            authenticator: ApiAuthenticator(),
          ),
        ) {
    TokenService.instance.initialize(
      baseUrl: baseUrl,
      clientId: clientId,
      clientSecret: clientSecret,
    );
  }
}
