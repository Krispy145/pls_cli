import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc_forms/bloc_forms.dart';
import 'dart:async';

part '{{name.snakeCase()}}_state.dart';
part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_bloc.freezed.dart';
part '{{name.snakeCase()}}_bloc.g.dart';

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc() : super({{name.pascalCase()}}State.initial()) {
    {{#inputs}}
      on<{{#pascalCase}}{{name}}_{{.}}{{/pascalCase}}Changed>(_on{{#pascalCase}}{{.}}{{/pascalCase}}Changed);
    {{/inputs}}

      on<{{name.pascalCase()}}Submitted>(_onSubmit);

  }

  {{#inputs}}
  FutureOr<void> _on{{#pascalCase}}{{.}}{{/pascalCase}}Changed(
    {{#pascalCase}}{{name}}_{{.}}{{/pascalCase}}Changed event,
    Emitter<{{name.pascalCase()}}State> emit,
  ) {
    emit(state.copyWith.{{#camelCase}}{{.}}{{/camelCase}}(value: event.value));
  }
  {{/inputs}}

   Future<void> _onSubmit(
    {{name.pascalCase()}}Submitted _,
    Emitter<{{name.pascalCase()}}State> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final newState = state.setAllInputsDirty().copyWith(isLoading: false);
    if (newState.isValid) {
      // Do something
    }
    emit(newState);
  }
}
