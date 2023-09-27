extension IterableExt<T> on Iterable<T> {}

/// Check if the Iterable is empty or null
extension EmptyOrNull<T> on Iterable<T?>? {
  bool get isEmptyOrNull {
    if (this == null) return true;

    if (this!.isEmpty) return true;

    return false;
  }

  bool get isNotEmptyOrNull => !isEmptyOrNull;
}
