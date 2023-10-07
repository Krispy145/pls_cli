import 'package:flutter/widgets.dart';
import 'package:flutter_template/app.dart';

import 'package:utilities/flavors/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlavorConfig flavorConfig = FlavorConfig(
    environment: Environment.production,
    apiPrefix: "",
  );

  appMain(flavorConfig: flavorConfig);
}
