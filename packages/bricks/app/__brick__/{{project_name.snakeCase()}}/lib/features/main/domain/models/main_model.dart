import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_model.freezed.dart';
part 'main_model.g.dart';

/// [MainModel] is a class that represents the main model.
@freezed
class MainModel with _$MainModel {
  /// [MainModel] constructor.
  const factory MainModel({
    required String name,
    required int age,
  }) = _MainModel;

  /// [MainModel] factory constructor.
  factory MainModel.fromJson(Map<String, dynamic> json) => _$MainModelFromJson(json);
}
