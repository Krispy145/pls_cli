import "package:mobx/mobx.dart";
import "package:utilities/flavors/flavor_config.dart";
import "package:utilities/widgets/load_state/store.dart";

/// [ConfigStore] is a class that holds all the configurations for the application.
/// [ConfigStore] extends [FlavorConfig] to inherit the properties of the [FlavorConfig] class.
/// [ConfigStore] is used to set variables for constants that are used throughout the application.
/// and requires hidden values from the environment files.

part "store.g.dart";

/// [ConfigStore] is a class that uses [_ConfigStore] to manage the state of the Config feature.
class ConfigStore = _ConfigStore with _$ConfigStore;

/// [_ConfigStore] is a class that manages the state of the Config feature.
abstract class _ConfigStore extends FlavorConfig with LoadStateStore, Store {
  final String domain;
  _ConfigStore({required super.environmentName, this.showDevTools = false, required super.loggerFeatures, required this.domain, super.overrideFeatures = false}) {
    setLoaded();
  }

  @observable
  bool showDevTools;

  @action
  void toggleDevTools() {
    showDevTools = !showDevTools;
  }
}
