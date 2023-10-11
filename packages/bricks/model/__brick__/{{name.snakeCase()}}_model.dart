import 'package:freezed_annotation/freezed_annotation.dart';

part '../{{name.camelCase()}}_model.freezed.dart';
{{#serializable}}
part '../{{name.camelCase()}}_model.g.dart';
{{/serializable}}

/// [{{name.pascalCase()}}Model] is a class that represents the {{name.camelCase()}} model.

@freezed
class {{name.pascalCase()}}Model with _${{name.pascalCase()}}Model {
/// [{{name.pascalCase()}}Model] constructor.
  const factory {{name.pascalCase()}}Model({
    required String name,
    required int age,
  }) = _{{name.pascalCase()}}Model;

{{#serializable}}
  /// [{{name.pascalCase()}}Model] factory constructor.
  factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) =>
      _${{name.pascalCase()}}ModelFromJson(json);
{{/serializable}}
}
