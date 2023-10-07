import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class MainModel with _$MainModel {
  const factory MainModel({
    required String name,
    required int age,
  }) = _MainModel;

  factory MainModel.fromJson(Map<String, dynamic> json) => _$MainModelFromJson(json);
}
