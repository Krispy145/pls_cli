import 'package:{{project_name.snakeCase()}}/main.dart';
import 'package:utilities/flavors/flavor_config.dart';

void main() {
  final FlavorConfig flavorConfig = FlavorConfig(
    environment: Environment.staging,
    apiPrefix: "",
  );
  appMain(flavorConfig: flavorConfig);
}
