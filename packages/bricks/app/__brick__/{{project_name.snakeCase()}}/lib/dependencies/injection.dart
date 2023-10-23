import 'package:get_it/get_it.dart';

{{#is_dashboard}}
import 'package:navigation/structures/dashboard_shell_structure/shell/store.dart';

{{/is_dashboard}}
{{#is_default_map}}
import 'package:navigation/structures/default_map_shell_structure/store.dart';

{{/is_default_map}}
{{#is_default}}
import 'package:navigation/structures/default_shell_structure/store.dart';

{{/is_default}}
{{#is_map}}
import 'package:navigation/structures/map_shell_structure/store.dart';

{{/is_map}}
import 'package:utilities/flavors/flavor_config.dart';
import 'package:utilities/flavors/flavor_manager.dart';
import 'package:utilities/logger/logger.dart';
import 'package:utilities/theme/wrapper/store.dart';
import 'package:utilities/widgets/connection_state/base_store.dart';

/// [Managers] is a variable that handles all service locator registrations.
// ignore: non_constant_identifier_names
final Managers = ManagerInjector.instance;

/// [ManagerInjector] is a class that handles all service locator registrations.
class ManagerInjector {
  /// [ManagerInjector] instance setter.
  static final ManagerInjector instance = ManagerInjector();
  final GetIt _serviceLocator = GetIt.instance;

  /// Method responsible for initialising all service locator registrations.
  void init({required FlavorConfig flavorConfig}) {
    AppLogger.print("Initializing ManagerInjector...", [LoggerFeatures.dependancyInjection]);

    // Core
    initCore(flavorConfig: flavorConfig);

    // App
    initApp();

    // External
    initExternal();
    AppLogger.print("ManagerInjector initialization complete.", [LoggerFeatures.dependancyInjection], type: LoggerType.confirmation);
  }

  /// Method responsible for handling all service locator registrations for core classes used in multiple features.
  void initCore({required FlavorConfig flavorConfig}) {
    AppLogger.print("Initializing core services...", [LoggerFeatures.dependancyInjection]);
    _serviceLocator
      ..registerLazySingleton<ConnectionStateStore>(ConnectionStateStore.new)
      ..registerLazySingleton<FlavorManager>(() => FlavorManager(flavorConfig: flavorConfig));

    ///END OF CORE
  }

  /// Method responsible for handling all service locator registrations for the app classes used in multiple features.
  void initApp() {
    AppLogger.print("Initializing app services...", [LoggerFeatures.dependancyInjection]);
    _serviceLocator.registerLazySingleton<ThemeStateStore>(() => ThemeStateStore(assetPath: '', useLocal: true));

    {{#is_default}}
    _serviceLocator.registerLazySingleton<DefaultShellStructureStore>(DefaultShellStructureStore.new);

    {{/is_default}}

    {{#is_default_map}}
    
    _serviceLocator.registerLazySingleton<DefaultMapShellStructureStore>(DefaultMapShellStructureStore.new);

    {{/is_default_map}}

    {{#is_map}}
    
    _serviceLocator.registerLazySingleton<MapShellStructureStore>(MapShellStructureStore.new);

    {{/is_map}}

    {{#is_dashboard}}
    
    _serviceLocator.registerLazySingleton<DashboardShellStructureStore>(DashboardShellStructureStore.new);

    {{/is_dashboard}}

    ///END OF APP
  }

  /// Method responsible for handling all service locator registrations for external services.
  void initExternal() {
    AppLogger.print("Initializing external services...", [LoggerFeatures.dependancyInjection]);

    ///END OF EXTERNAL
  }

  /// Getters for all services
  /// [FlavorManager] getter
  FlavorManager get _flavor => _serviceLocator.get<FlavorManager>();

  /// [FlavorConfig] getter
  FlavorConfig get flavor => _flavor.flavorConfig;

  /// [ConnectionStateBaseStore] getter
  ConnectionStateStore get connectionStateStore => _serviceLocator.get<ConnectionStateStore>();

  /// [ThemeStateStore] getter
  ThemeStateStore get themeStateStore => _serviceLocator.get<ThemeStateStore>();

  {{#is_default}}
  /// [DefaultShellStructureStore] getter
  DefaultShellStructureStore get defaultShellStore => _serviceLocator.get<DefaultShellStructureStore>();

  {{/is_default}}

  {{#is_default_map}}
  /// [DefaultMapShellStructureStore] getter
  DefaultMapShellStructureStore get defaultMapShellStore => _serviceLocator.get<DefaultMapShellStructureStore>();

  {{/is_default_map}}

  {{#is_map}}
  /// [MapShellStructureStore] getter
  MapShellStructureStore get mapShellStore => _serviceLocator.get<MapShellStructureStore>();

  {{/is_map}}

  {{#is_dashboard}}
  /// [DashboardShellStructureStore] getter
  DashboardShellStructureStore get dashboardShellStore => _serviceLocator.get<DashboardShellStructureStore>();

  {{/is_dashboard}}
}
