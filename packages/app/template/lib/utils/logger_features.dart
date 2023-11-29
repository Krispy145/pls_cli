import 'package:utilities/logger/logger.dart';

/// [AppLoggerFeatures] extends [LoggerFeatures], and is a class that defines all logger features used in the app.
extension AppLoggerFeatures on LoggerFeatures {
  /// main logger feature.
  static final LoggerFeature main = LoggerFeature("MAIN", true);

  /// home logger feature.
  static final LoggerFeature home = LoggerFeature("HOME", true);

  ///LOGGER FEATURE END
}
