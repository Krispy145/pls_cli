import 'package:flutter/material.dart';
import 'package:flutter_template/dependency_injection/injection_container.dart';
import 'package:flutter_template/navigation/routes.dart';
import 'package:utilities/flavors/flavor_config.dart';

void appMain({required FlavorConfig flavorConfig}) {
  WidgetsFlutterBinding.ensureInitialized();
  Managers.init(flavorConfig: flavorConfig);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '{{project_name.titleCase()}}',
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: themeManager.themeMode,
      routerConfig: AppRouter.router,
    );
  }
}
