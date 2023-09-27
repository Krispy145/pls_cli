part of '{{name.snakeCase()}}_bloc.dart';

@immutable
abstract class {{name.pascalCase()}}Event{}

{{#events}}
class {{name.pascalCase()}}{{#pascalCase}}{{.}}{{/pascalCase}} extends {{name.pascalCase()}}Event{}
{{/events}}