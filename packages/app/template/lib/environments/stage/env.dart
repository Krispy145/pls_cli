import "package:envied/envied.dart";
import "package:utilities/flavors/flavor_config.dart";

part "env.g.dart";

/// Stage Environment
@Envied(path: "lib/environments/stage/.env", name: "StageEnv")
class StageEnv implements Env {
  /// Name of the environment
  @EnviedField(obfuscate: true)
  static const String name = _StageEnv.name;

  /// Key1
  @EnviedField(obfuscate: true)
  static String key1 = _StageEnv.key1;
}
