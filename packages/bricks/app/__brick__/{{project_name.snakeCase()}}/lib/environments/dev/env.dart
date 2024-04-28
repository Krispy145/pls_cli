import "package:envied/envied.dart";
import "package:utilities/flavors/flavor_config.dart";

part "env.g.dart";

/// Dev Environment
@Envied(path: "lib/environments/dev/.env", name: "DevEnv")
class DevEnv implements Env {
  /// Name of the environment
  @EnviedField(obfuscate: true)
  static const String name = _DevEnv.name;

  /// Key1
  @EnviedField(obfuscate: true)
  static String key1 = _DevEnv.key1;
}
