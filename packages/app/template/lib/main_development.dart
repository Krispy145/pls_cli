import 'package:flutter_template/app.dart';
import 'package:utilities/flavors/flavor_config.dart';

void main() {
  final FlavorConfig flavorConfig = FlavorConfig(
    environment: Environment.development,
    apiPrefix: "",
  );
  appMain(flavorConfig: flavorConfig);
}
