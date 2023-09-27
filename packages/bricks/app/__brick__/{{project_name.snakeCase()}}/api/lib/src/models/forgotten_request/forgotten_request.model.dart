import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgotten_request.model.freezed.dart';

part 'forgotten_request.model.g.dart';

@freezed
class ForgottenRequestModel with _$ForgottenRequestModel {
  const factory ForgottenRequestModel({
    required String email,
    required String resetUrl,
  }) = _ForgottenRequestModel;

  factory ForgottenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgottenRequestModelFromJson(json);
}
