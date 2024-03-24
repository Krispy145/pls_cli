import 'package:utilities/logger/logger.dart';

/// [AppLoggerFeatures] extends [LoggerFeatures], and is a class that defines all logger features used in the app.
class AppLoggerFeatures extends LoggerFeatures {
  

  /// [AppLoggerFeatures] constructor.
  const AppLoggerFeatures({    
    super.logNavigation = false,
    super.logConnection = false,
    super.logDependencyInjection = false,
    super.logTheme = false,
    super.logAdMob = false,
    super.logNotifications = false,
    super.logLocalDataSource = false,
    super.logSecureDataSource = false,
    super.logApiDataSource = false,
    super.logFirestoreDataSource = false,
    super.logAuthentication = false,
    super.logConverters = false,
    super.logDeeplinks = false,
  });

  ///LOGGER FEATURE END
}
