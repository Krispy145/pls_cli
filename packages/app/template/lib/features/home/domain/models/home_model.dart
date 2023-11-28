import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'home_model.freezed.dart';
part 'home_model.g.dart';

/// [HomeModel] is a class that represents the main model.
@freezed
@HiveType(typeId: 2)
class HomeModel with _$HomeModel {
  /// [HomeModel] constructor.
  const factory HomeModel({
    @HiveField(0) required String name,
    @HiveField(1) required int age,
  }) = _HomeModel;

  /// [HomeModel] factory constructor.
  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);
}
