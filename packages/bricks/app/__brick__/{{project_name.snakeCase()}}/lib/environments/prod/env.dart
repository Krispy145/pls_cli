import 'package:envied/envied.dart';
import 'package:utilities/flavors/flavor_config.dart';

part 'env.g.dart';

/// Prod Environment
@Envied(path: 'lib/environments/prod/.env', name: "ProdEnv")
class ProdEnv implements Env {
  /// Name of the environment
  @EnviedField()
  static const String name = _ProdEnv.name;

  /// Key1
  @EnviedField(obfuscate: true)
  static String key1 = _ProdEnv.key1;
}
