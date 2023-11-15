import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_model.freezed.dart';
part 'home_model.g.dart';

/// [HomeModel] is a class that represents the home model.
@freezed
class HomeModel with _$HomeModel {
  /// [HomeModel] constructor.
  const factory HomeModel({
    required String name,
    required int age,
  }) = _HomeModel;

  /// [HomeModel] factory constructor.
  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);
}
