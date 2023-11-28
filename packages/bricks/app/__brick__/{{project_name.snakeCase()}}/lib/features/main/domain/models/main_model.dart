import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'main_model.freezed.dart';
part 'main_model.g.dart';

/// [MainModel] is a class that represents the main model.
@freezed
@HiveType(typeId: 2)
class MainModel with _$MainModel {
  /// [MainModel] constructor.
  const factory MainModel({
    @HiveField(0) required String name,
    @HiveField(1) required int age,
  }) = _MainModel;

  /// [MainModel] factory constructor.
  factory MainModel.fromJson(Map<String, dynamic> json) =>
      _$MainModelFromJson(json);
}
