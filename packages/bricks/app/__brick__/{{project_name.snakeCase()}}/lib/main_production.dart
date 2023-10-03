import 'package:{{project_name.snakeCase()}}/app.dart';
import 'package:utilities/flavors/flavor_config.dart';

void main() {
  final FlavorConfig flavorConfig = FlavorConfig(
    environment: Environment.production,
    apiPrefix: "",
  );
  appMain(flavorConfig: flavorConfig);
}
