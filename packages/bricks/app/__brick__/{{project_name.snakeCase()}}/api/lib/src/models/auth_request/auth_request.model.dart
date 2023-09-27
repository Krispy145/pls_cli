import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.model.freezed.dart';

part 'auth_request.model.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum GrantType { password, social }

@freezed
class AuthRequestModel with _$AuthRequestModel {
  const factory AuthRequestModel({
    required GrantType grantType,
    required String clientId,
    required String clientSecret,
    String? username,
    String? password,
    String? refreshToken,
    String? code,
    String? redirectUri,
  }) = _AuthRequestModel;

  factory AuthRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestModelFromJson(json);
}
