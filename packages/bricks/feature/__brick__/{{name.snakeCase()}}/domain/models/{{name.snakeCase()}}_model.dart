import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_model.freezed.dart';
part '{{name.snakeCase()}}_model.g.dart';

@freezed
class {{name.titleCase()}}Model with _${{name.titleCase()}}Model {
  const factory {{name.titleCase()}}Model({
    required String name,
    required int age,
  }) = _{{name.titleCase()}}Model;

  factory {{name.titleCase()}}Model.fromJson(Map<String, dynamic> json) => _${{name.titleCase()}}ModelFromJson(json);
}
