
import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/dependency_injection/injection_container.dart';

import 'package:{{project_name.snakeCase()}}/navigation/routes.dart';
import 'package:utilities/flavors/flavor_config.dart';

/// Main App Function
void appMain({required FlavorConfig flavorConfig})  {
  Managers.init(flavorConfig: flavorConfig);
  
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Digital Oasis Test',
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: themeManager.themeMode,
      routerConfig: AppRouter.router(
        
        
      ),
    );
  }
}
