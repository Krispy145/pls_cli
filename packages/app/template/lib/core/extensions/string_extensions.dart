/// Capitalize the first character of a string
extension StringExt on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String removeNull() {
    return replaceAll("null", "");
  }

  /// Get the last character of a string
  String? get last {
    if (isEmpty) {
      return null;
    }
    return substring(length - 1);
  }

  /// uncomment if needed (requires extra package)
  // String cleanHtml() {
  //   final htmlEsc = HtmlUnescape();
  //   final document = parse(this);
  //   final pList = document.body!.querySelectorAll("p");
  //   final out = pList.mapIndexed(
  //     (i, p) => "${p.text}${i == pList.length - 1 ? "" : "\n\n"}",
  //   );
  //   return htmlEsc.convert(out.join());
  // }
}

extension StringNullExt on String? {
  bool get isEmptyOrNull {
    if (this == null) return true;

    if (this!.isEmpty) return true;

    return false;
  }

  bool get isNotEmptyOrNull => !isEmptyOrNull;
}
