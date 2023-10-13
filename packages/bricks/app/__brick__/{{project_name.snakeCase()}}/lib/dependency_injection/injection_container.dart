// ignore_for_file: unnecessary_lambdas,
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
import 'package:utilities/network_info/network_info.dart';

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
    Logger.print("Initializing ManagerInjector...", [LoggerFeatures.dependancyInjection]);

    // Core
    initCore(flavorConfig: flavorConfig);

    // App
    initApp();

    // External
    initExternal();
    Logger.print("ManagerInjector initialization complete.", [LoggerFeatures.dependancyInjection], type: LoggerType.confirmation);
  }

  /// Method responsible for handling all service locator registrations for core classes used in multiple features.
  void initCore({required FlavorConfig flavorConfig}) {
    Logger.print("Initializing core services...", [LoggerFeatures.dependancyInjection]);
    _serviceLocator
      ..registerLazySingleton<NetworkInfo>(() => NetworkInfo(_serviceLocator()))
      ..registerLazySingleton<FlavorManager>(() => FlavorManager(flavorConfig: flavorConfig));

    ///END OF CORE
  }

  /// Method responsible for handling all service locator registrations for the app classes used in multiple features.
  void initApp() {
    Logger.print("Initializing app services...", [LoggerFeatures.dependancyInjection]);

    {{#is_default}}
    _serviceLocator.registerLazySingleton<DefaultShellStructureStore>(() => DefaultShellStructureStore());

    {{/is_default}}

    {{#is_default_map}}
    
    _serviceLocator.registerLazySingleton<DefaultMapShellStructureStore>(() => DefaultMapShellStructureStore());

    {{/is_default_map}}

    {{#is_map}}
    
    _serviceLocator.registerLazySingleton<MapShellStructureStore>(() => MapShellStructureStore());

    {{/is_map}}

    {{#is_dashboard}}
    
    _serviceLocator.registerLazySingleton<DashboardShellStructureStore>(() => DashboardShellStructureStore());

    {{/is_dashboard}}

    ///END OF APP
  }

  /// Method responsible for handling all service locator registrations for external services.
  void initExternal() {
    Logger.print("Initializing external services...", [LoggerFeatures.dependancyInjection]);
    _serviceLocator.registerLazySingleton(() => InternetConnectionChecker());

    ///END OF EXTERNAL
  }

  /// Getters for all services
  /// [FlavorManager] getter
  FlavorManager get _flavor => _serviceLocator.get<FlavorManager>();

  /// [FlavorConfig] getter
  FlavorConfig get flavor => _flavor.flavorConfig;

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
