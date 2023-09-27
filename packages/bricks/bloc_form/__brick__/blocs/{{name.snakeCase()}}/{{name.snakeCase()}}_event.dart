part of "{{name.snakeCase()}}_bloc.dart";

@immutable
abstract class {{name.pascalCase()}}Event{
  const {{name.pascalCase()}}Event();
}

{{#inputs}}
class {{#pascalCase}}{{name}}_{{.}}{{/pascalCase}}Changed extends {{name.pascalCase()}}Event{
  final String value;
  const {{#pascalCase}}{{name}}_{{.}}{{/pascalCase}}Changed(this.value);
}
{{/inputs}}

class {{name.pascalCase()}}Submitted extends {{name.pascalCase()}}Event {}