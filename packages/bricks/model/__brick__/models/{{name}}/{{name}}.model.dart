import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name}}.model.freezed.dart';
{{#serializable}}
part '{{name}}.model.g.dart';
{{/serializable}}

@freezed
class {{name.pascalCase()}}Model with _${{name.pascalCase()}}Model {
  const factory {{name.pascalCase()}}Model({}) = _{{name.pascalCase()}}Model;

{{#serializable}}
  factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) =>
      _${{name.pascalCase()}}ModelFromJson(json);
{{/serializable}}
}