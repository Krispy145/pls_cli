import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_result.model.freezed.dart';

part 'auth_result.model.g.dart';

@freezed
class AuthResultModel with _$AuthResultModel {
  const factory AuthResultModel({
    required String tokenType,
    required int expiresIn,
    required String accessToken,
    required String refreshToken,
  }) = _AuthResultModel;

  factory AuthResultModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResultModelFromJson(json);
}
