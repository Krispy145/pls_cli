import 'package:analyzer/dart/analysis/results.dart';
import 'package:recase/recase.dart';
import 'package:render_cli/src/commands/add/form_input/form_names.dart';

/// Builds the form ui component
String buildComponent({required FormNames names, required bool isBloc}) {
  final inputName = names.inputName.pascalCase;
  final blocNameShort = names.blocNameShort.pascalCase;
  final blocName = names.blocName.pascalCase;
  String onChangeText;
  if (isBloc) {
    onChangeText =
        "context.read<$blocName>().add($blocNameShort${names.eventName.pascalCase}(value))";
  } else {
    onChangeText =
        "context.read<$blocName>().${names.eventName.camelCase}(value)";
  }
  return """
class _$inputName extends StatelessWidget {
  const _$inputName({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<$blocName, ${blocNameShort}State, String?>(
      selector: (state) => state.${inputName.camelCase}.error,
      builder: (context, error) => TextInput.withError(
        labelText: "$inputName",
        error: error,
        onChanged: (value) => $onChangeText,
      ),
    );
  }
}
    """;
}

/// Build a bloc event class
String buildBlocEvent({required FormNames names}) {
  final blocNameShort = names.blocNameShort.pascalCase;

  final eventName = names.eventName.pascalCase;
  return """
    class $blocNameShort$eventName extends ${blocNameShort}Event {
        final String? value;
        const $blocNameShort$eventName(this.value);
    }
    """;
}

/// build a bloc event by writing whole file
String buildBlocEventHandler({
  required ParseStringResult parsedFile,
  required FormNames names,
  required int constructorEnd,
  required int closingOffset,
  required bool isBloc,
}) {
  if (!isBloc) {
    return """
    ${parsedFile.content.substring(0, closingOffset)}
    void ${names.eventName.camelCase}(String value) => emit(state.copyWith.${names.inputName.camelCase}(value: value));
    ${parsedFile.content.substring(closingOffset)}
    """;
  }
  return """${parsedFile.content.substring(0, constructorEnd - 1)}
        on<${names.blocNameShort.pascalCase}${names.eventName.pascalCase}>(_on${names.eventName.pascalCase});
      ${parsedFile.content.substring(constructorEnd - 1, closingOffset)}
      FutureOr<void>_on${names.eventName.pascalCase}(
        ${names.blocNameShort.pascalCase}${names.eventName.pascalCase} event,
        Emitter<${names.blocNameShort.pascalCase}State> emit,
      ){
        emit(state.copyWith.${names.inputName.camelCase}(value: event.value));
      }
      ${parsedFile.content.substring(closingOffset)}
    """;
}
