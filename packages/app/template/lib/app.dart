
import 'package:flutter/material.dart';
import 'package:flutter_template/dependency_injection/injection_container.dart';

import 'package:flutter_template/navigation/routes.dart';
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
      title: 'Flutter Template',
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: themeManager.themeMode,
      routerConfig: AppRouter.router(
        
        
      ),
    );
  }
}
