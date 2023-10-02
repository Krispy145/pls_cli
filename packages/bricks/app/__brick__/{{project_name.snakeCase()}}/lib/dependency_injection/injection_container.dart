// ignore_for_file: unnecessary_lambdas, non_constant_identifier_names
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:navigation/structures/default_shell_structure/store.dart';
// import 'package:utilities/ads/store.dart';
import 'package:utilities/flavors/flavor_config.dart';
import 'package:utilities/flavors/flavor_manager.dart';
import 'package:utilities/logger/logger.dart';
import 'package:utilities/network_info/network_info.dart';

final Managers = ManagerInjector.instance;

class ManagerInjector {
  static final ManagerInjector instance = ManagerInjector();
  final GetIt _serviceLocator = GetIt.instance;

  ///Method responsible for initialising all service locator registrations.
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

  ///Method responsible for handling all service locator registrations for core
  ///classes used in multiple features.
  void initCore({required FlavorConfig flavorConfig}) {
    Logger.print("Initializing core services...", [LoggerFeatures.dependancyInjection]);
    _serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfo(_serviceLocator()));
    _serviceLocator.registerLazySingleton<FlavorManager>(() => FlavorManager(flavorConfig: flavorConfig));
    // _serviceLocator.registerLazySingleton<AdMobStore>(() => AdMobStore(bannerAdUnitId: null, interstitialAdUnitId: null, rewardAdUnitId: null));
  }

  ///Method responsible for handling all service locator registrations for the app
  ///classes used in multiple features.
  void initApp() {
    Logger.print("Initializing app services...", [LoggerFeatures.dependancyInjection]);
    _serviceLocator.registerLazySingleton<DefaultShellStructureStore>(() => DefaultShellStructureStore());
  }

  ///Method responsible for handling all service locator registrations for external
  ///services.
  void initExternal() {
    Logger.print("Initializing external services...", [LoggerFeatures.dependancyInjection]);
    _serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
  }

  // Getters for all services
  //Managers
  FlavorManager get _flavor => _serviceLocator.get<FlavorManager>();
  // AdMobStore get adMobStore => _serviceLocator.get<AdMobStore>();
  FlavorConfig get flavor => _flavor.flavorConfig;
  DefaultShellStructureStore get defaultShellStore => _serviceLocator.get<DefaultShellStructureStore>();
}
