import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/_core.dart';
import '../blocs/{{name}}/{{name}}_cubit.dart';

class {{componentName.pascalCase()}} extends StatelessWidget {
  const {{componentName.pascalCase()}}({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{name.pascalCase()}}Cubit(),
      child: RemoveFocusWrapper(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              {{#inputs}}
              const _{{#pascalCase}}{{.}}{{/pascalCase}}(),
              {{/inputs}}
            ],
          ),
        ),
      ),
    );
  }
}

{{#inputs}}
class _{{#pascalCase}}{{.}}{{/pascalCase}} extends StatelessWidget {
  const _{{#pascalCase}}{{.}}{{/pascalCase}}({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}State, String?>(
      selector: (state) => state.{{#camelCase}}{{.}}{{/camelCase}}.error,
      builder: (context, error) => TextInput.withError(
        labelText: "{{#pascalCase}}{{.}}{{/pascalCase}}",
        error: error,
        onChanged: (value) =>
            context.read<{{name.pascalCase()}}Cubit>().{{#camelCase}}{{.}}{{/camelCase}}Changed(value),
      ),
    );
  }
}
{{/inputs}}
