import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part '{{name.snakeCase()}}_model.freezed.dart';
part '{{name.snakeCase()}}_model.g.dart';

/// [{{name.pascalCase()}}Model] is a class that represents the main model.
@freezed
@HiveType(typeId: 2)
class {{name.pascalCase()}}Model with _${{name.pascalCase()}}Model {
  /// [{{name.pascalCase()}}Model] constructor.
  const factory {{name.pascalCase()}}Model({
    @HiveField(0) required String name,
    @HiveField(1) required int age,
  }) = _{{name.pascalCase()}}Model;

  /// [{{name.pascalCase()}}Model] factory constructor.
  factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) =>
      _${{name.pascalCase()}}ModelFromJson(json);
}
