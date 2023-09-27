import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';
part '{{name.snakeCase()}}_bloc.freezed.dart';

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc() : super(const {{name.pascalCase()}}State()) {
  {{#events}}
    on<{{name.pascalCase()}}{{#pascalCase}}{{.}}{{/pascalCase}}>(_on{{#pascalCase}}{{.}}{{/pascalCase}});
  {{/events}}

  }

  {{#events}}
  FutureOr<void> _on{{#pascalCase}}{{.}}{{/pascalCase}}(
  {{name.pascalCase()}}{{#pascalCase}}{{.}}{{/pascalCase}} event,
    Emitter<{{name.pascalCase()}}State> emit,
  ) {}
  {{/events}}
}
