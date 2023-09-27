import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc_forms/annotations/bloc_forms.dart';
import 'package:bloc_forms/bloc_forms.dart';

part '{{name.snakeCase()}}_state.dart';
part '{{name.snakeCase()}}_cubit.freezed.dart';
part '{{name.snakeCase()}}_cubit.g.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> {
  {{name.pascalCase()}}Cubit() : super({{name.pascalCase()}}State.initial());

  {{#inputs}}
   void {{#camelCase}}{{.}}{{/camelCase}}Changed(String {{#camelCase}}{{.}}{{/camelCase}}) => emit(state.copyWith.{{#camelCase}}{{.}}{{/camelCase}}(value: {{#camelCase}}{{.}}{{/camelCase}}));
  {{/inputs}}

  
   Future<void> submit() async {
    emit(state.copyWith(isLoading: true));
    final newState = state.setAllInputsDirty().copyWith(isLoading: false);
    if (newState.isValid) {
      // Do something
    }
    emit(newState);
  }
}
