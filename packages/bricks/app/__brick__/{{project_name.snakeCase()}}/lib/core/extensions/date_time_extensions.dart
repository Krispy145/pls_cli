import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Custom format for a [DateTime]. Passes the calculated day suffix.
typedef CustomFormat = String Function(String);

extension DateExt on DateTime {
  /// Formats the date with the day suffix.
  ///
  /// By default formats the date like: 8th Apr 22.
  /// For other formats pass a [CustomFormat]
  String formatWithSuffix({CustomFormat? customFormat}) {
    var suffix = "th";
    final digit = day % 10;
    if ((digit > 0 && digit < 4) && (day < 11 || day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    return DateFormat(
      customFormat != null ? customFormat(suffix) : "d'$suffix' MMM yy",
    ).format(this);
  }

  String toApiFormat() {
    return DateFormat("yyyy-MM-dd").format(this);
  }
}

extension TimeOfDayExt on TimeOfDay {
  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
