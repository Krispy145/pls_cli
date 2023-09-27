/// The various names needed for the templates
class FormNames {
  /// The name inputted by the user
  final String inputName;

  /// The name of the event used in the bloc
  final String eventName;

  /// The name of the bloc, from the file name
  final String blocName;

  /// The name of the bloc, from the file name and without "_bloc"
  final String blocNameShort;

  /// The name of the file where the form component is stored
  final String componentFileName;

  ///
  factory FormNames({
    required String inputName,
    required String blocName,
  }) {
    final blocNameShort =
        blocName.replaceAll("_bloc", "").replaceAll("_cubit", "");
    final eventName = "${inputName}_Changed";
    final componentFileName = blocNameShort.contains("_form")
        ? blocNameShort
        : "${blocNameShort}_form";

    return FormNames._(
      blocNameShort: blocNameShort,
      componentFileName: componentFileName,
      inputName: inputName,
      eventName: eventName,
      blocName: blocName,
    );
  }

  const FormNames._({
    required this.blocNameShort,
    required this.componentFileName,
    required this.blocName,
    required this.inputName,
    required this.eventName,
  });
}
