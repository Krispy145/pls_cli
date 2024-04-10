import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_model.freezed.dart';
part '{{name.snakeCase()}}_model.g.dart';

/// [{{name.pascalCase()}}Model] is a class that represents the main model.
@freezed
class {{name.pascalCase()}}Model with _${{name.pascalCase()}}Model {
  /// [{{name.pascalCase()}}Model] constructor.
  const factory {{name.pascalCase()}}Model({
    required String id,
     String? name,    
  }) = _{{name.pascalCase()}}Model;

  /// [{{name.pascalCase()}}Model] factory constructor.
  factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) => _${{name.pascalCase()}}ModelFromJson(json);
}
