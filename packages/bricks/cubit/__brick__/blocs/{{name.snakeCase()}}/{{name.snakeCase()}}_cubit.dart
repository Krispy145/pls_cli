import 'package:flutter_bloc/flutter_bloc.dart';

{{#hasState}}
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_state.dart';
part '{{name.snakeCase()}}_cubit.freezed.dart';
{{/hasState}}

class {{name.pascalCase()}}Cubit extends Cubit<{{#hasState}}{{name.pascalCase()}}State{{/hasState}}{{^hasState}}int{{/hasState}}> {
  {{name.pascalCase()}}Cubit() : super({{#hasState}}const {{name.pascalCase()}}State(){{/hasState}}{{^hasState}}0{{/hasState}});
}
