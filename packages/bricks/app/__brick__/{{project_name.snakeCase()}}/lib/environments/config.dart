import "package:utilities/flavors/flavor_config.dart";

/// [Config] is a class that holds all the configurations for the application.
/// [Config] extends [FlavorConfig] to inherit the properties of the [FlavorConfig] class.
/// [Config] is used to set variables for constants that are used throughout the application.
/// and requires hidden values from the environment files.
class Config extends FlavorConfig {
  final bool showDevTools;
  Config(
    super._environmentName, {
    this.showDevTools = false,
    required super.apiPrefix,
    required super.loggerFeatures,
  });
}
