import 'package:app_template/core/assets/assets.gen.dart';
import 'package:app_template/environments/config.dart';
import 'package:app_template/navigation/routes.dart';
import 'package:app_template/utils/loggers.dart';
import 'package:get_it/get_it.dart';
import 'package:theme/app/store.dart';
import 'package:name_template/utils/loggers.dart';
/// IS_DASHBOARD START
import 'package:navigation/structures/dashboard/store.dart';

/// IS_DASHBOARD END
/// IS_DEFAULTMAP START
import 'package:navigation/structures/default_map/store.dart';

/// IS_DEFAULTMAP END
/// IS_DEFAULT START
import 'package:navigation/structures/default/store.dart';

/// IS_DEFAULT END
/// IS_MAP START
import 'package:navigation/structures/map/store.dart';

/// IS_MAP END
import 'package:utilities/flavors/flavor_manager.dart';
import 'package:utilities/logger/logger.dart';
import 'package:utilities/widgets/connection_state/base_store.dart';

/// [Managers] is a variable that handles all service locator registrations.
// ignore: non_constant_identifier_names
final Managers = ManagerInjector.instance;

/// [ManagerInjector] is a class that handles all service locator registrations.
class ManagerInjector {
  /// [ManagerInjector] instance setter.
  static final ManagerInjector instance = ManagerInjector();
  final GetIt _serviceLocator = GetIt.instance;

  /// [init] is responsible for initialising all service locator registrations.
  void init({required Config config}) {
    final _loggerInjector = AppLoggerInjector(config.loggerFeatures);
    _serviceLocator.registerLazySingleton<AppLoggerInjector>(() => _loggerInjector);
    AppLogger.print("Initializing ManagerInjector...", [NameTemplateLoggers.dependencyInjection]);
    _initCore(config: config);
    _initApp();
    _initExternal();
    AppLogger.print("ManagerInjector initialization complete.", [NameTemplateLoggers.dependencyInjection], type: LoggerType.confirmation);
  }


  /// [add] is responsible for adding a service locator registration.
  void add<T extends Object>(T instance) {
    _serviceLocator.registerSingleton<T>(instance);
  }

  /// [addLazy] is responsible for adding a lazy service locator registration.
  void addLazy<T extends Object>(T instance) {
    _serviceLocator.registerLazySingleton<T>(() => instance);
  }

  /// [addAsync] is responsible for adding an async service locator registration.
  Future<void> addAsync<T extends Object>(T instance) async {
    _serviceLocator.registerSingletonAsync<T>(() async => instance);
  }

  /// [addLazyAsync] is responsible for adding a lazy async service locator registration.
  Future<void> addLazyAsync<T extends Object>(T instance) async {
    _serviceLocator.registerLazySingletonAsync<T>(() async => instance);
  }

  /// [resetLazy] is responsible for resetting a lazy service locator registration.
  Future<void> resetLazy<T extends Object>() async {
    await _serviceLocator.resetLazySingleton<T>();
  }

  /// [resetAll] is responsible for resetting all service locator registrations.
  Future<void> resetAll() async {
    await _serviceLocator.reset();
  }

  /// Method responsible for handling all service locator registrations for core classes used in multiple features.
  void _initCore({required Config config}) {
    AppLogger.print("Initializing core services...", [NameTemplateLoggers.dependencyInjection]);
    _serviceLocator
    ..registerSingleton(AppRouter())
      ..registerLazySingleton<ConnectionStateStore>(ConnectionStateStore.new)
      ..registerLazySingleton<FlavorManager>(() => FlavorManager(flavorConfig: config));
      

    ///END OF CORE
  }

  /// Method responsible for handling all service locator registrations for the app classes used in multiple features.
  void _initApp() {
    AppLogger.print("Initializing app services...", [NameTemplateLoggers.dependencyInjection]);
     _serviceLocator
      ..registerLazySingleton<ThemeStateStore>(
        () => ThemeStateStore.assets(
          baseThemeAssetPath: Assets.themes.baseTheme,
          componentThemesAssetPath: Assets.themes.componentsThemes,
        ),
      )

    /// IS_DEFAULT START
    ..registerLazySingleton<DefaultShellStructureStore>(DefaultShellStructureStore.new);

    /// IS_DEFAULT END

    /// IS_DEFAULTMAP START
    ..registerLazySingleton<DefaultMapShellStructureStore>(DefaultMapShellStructureStore.new);

    /// IS_DEFAULTMAP END

    /// IS_MAP START
    ..registerLazySingleton<MapShellStructureStore>(MapShellStructureStore.new);

    /// IS_MAP END

    /// IS_DASHBOARD START
    ..registerLazySingleton<DashboardShellStructureStore>(DashboardShellStructureStore.new);

    /// IS_DASHBOARD END

    ///END OF APP
  }

  /// Method responsible for handling all service locator registrations for external services.
  void _initExternal() {
    AppLogger.print("Initializing external services...", [NameTemplateLoggers.dependencyInjection]);

    ///END OF EXTERNAL
  }



  

  /// Getters for all services
  /// [AppRouter] getter
  AppRouter get router => _serviceLocator.get<AppRouter>();
  
  /// [FlavorManager] getter
  FlavorManager get _flavor => _serviceLocator.get<FlavorManager>();

  /// [Config] getter
  Config get config => _flavor.flavorConfig as Config;

  /// [ConnectionStateBaseStore] getter
  ConnectionStateStore get connectionStateStore => _serviceLocator.get<ConnectionStateStore>();

  /// [ThemeStateStore] getter
  ThemeStateStore get themeStateStore => _serviceLocator.get<ThemeStateStore>();

  /// IS_DEFAULT START
  /// [DefaultShellStructureStore] getter
  DefaultShellStructureStore get defaultShellStore => _serviceLocator.get<DefaultShellStructureStore>();

  /// IS_DEFAULT END

  /// IS_DEFAULTMAP START
  /// [DefaultMapShellStructureStore] getter
  DefaultMapShellStructureStore get defaultMapShellStore => _serviceLocator.get<DefaultMapShellStructureStore>();

  /// IS_DEFAULTMAP END

  /// IS_MAP START
  /// [MapShellStructureStore] getter
  MapShellStructureStore get mapShellStore => _serviceLocator.get<MapShellStructureStore>();

  /// IS_MAP END

  /// IS_DASHBOARD START
  /// [DashboardShellStructureStore] getter
  DashboardShellStructureStore get dashboardShellStore => _serviceLocator.get<DashboardShellStructureStore>();

  /// IS_DASHBOARD END
}
