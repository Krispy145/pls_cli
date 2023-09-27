import 'dart:convert';

import 'package:flutter/services.dart';

enum Environment { dev, stage, prod }

/// Base controller for multiple environments
class Config {
  /// Singleton instance of [Config]
  static final instance = Config._();

  /// Current environment the build is running in.
  late final Environment env;

  late final Map<String, dynamic> _configMap;
  // ignore: unused_field
  final bool _subscriptionOverride = false;
  bool _hasBeenInitialized = false;

  Config._();

  /// Base url for the running environment.
  String get baseUrl => _getConfig("baseUrl") as String;

  /// Social Auth Redirect Uri
  String get socialRedirectUri => _getConfig("socialRedirectUri") as String;

  /// Client secret for the running environment.
  String get clientSecret => _getConfig("clientSecret") as String;

  /// Client id for the running environment.
  String get clientId => _getConfig("clientId") as String;

  /// Application Token for the running environment.
  String get applicationToken => _getConfig("applicationToken") as String;

  /// The reset password uri used in the email sent to the user.
  String get resetPasswordUri => _getConfig("resetPasswordUri") as String;

  /// Helper to show whether current environment is development
  bool get isDev => env == Environment.dev;

  /// Helper to show whether current environment is production
  bool get isProd => env == Environment.prod;

  /// Helper to show whether current environment is staging
  bool get isStage => env == Environment.stage;

  /// Read the config file from the given [path].
  ///
  /// Must call this at the beginning of the app.
  Future<void> initialize(
    String path,
    Environment env,
  ) async {
    assert(
      _hasBeenInitialized == false,
      "Only initialize config once at the beginning of the app",
    );
    // only allow initialization once;
    if (_hasBeenInitialized) return;
    _hasBeenInitialized = true;

    this.env = env;

    final configString = await rootBundle.loadString(path);
    _configMap = jsonDecode(configString) as Map<String, dynamic>;
  }

  // This internal method is simply to advise if config has not been initialized
  dynamic _getConfig(String key) {
    assert(_hasBeenInitialized, "Config hasn't been initialized.");
    return _configMap[key];
  }
}
