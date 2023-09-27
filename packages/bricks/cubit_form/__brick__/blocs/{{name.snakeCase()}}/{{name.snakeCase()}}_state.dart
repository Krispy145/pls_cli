part of '{{name.snakeCase()}}_cubit.dart';

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {

  @formConstructor
  const factory {{name.pascalCase()}}State({
    {{#inputs}}
    required FormInputModel<String> {{#camelCase}}{{.}}{{/camelCase}},
    {{/inputs}}
    @Default(false) bool isLoading,
    String? formError,
  }) = _{{name.pascalCase()}}State;

  // initial state
  factory {{name.pascalCase()}}State.initial() => {{name.pascalCase()}}State(
    {{#inputs}}
    {{#camelCase}}{{.}}{{/camelCase}}: FormInputModel(validator: (value) => value.required()),
    {{/inputs}}
  );
}