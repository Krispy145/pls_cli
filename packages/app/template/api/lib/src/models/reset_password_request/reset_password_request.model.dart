import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_request.model.freezed.dart';

part 'reset_password_request.model.g.dart';

@freezed
class ResetPasswordRequestModel with _$ResetPasswordRequestModel {
  const factory ResetPasswordRequestModel({
    required String email,
    required String password,
    required String token,
  }) = _ResetPasswordRequestModel;

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestModelFromJson(json);
}
