import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/not_found_screen.dart';

class NusaTravelApp extends StatelessWidget {
  const NusaTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Poin 8: Konfigurasi MaterialApp (initialRoute, routes, onGenerateRoute, onUnknownRoute)
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NusaTravel',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.detail) {
          return MaterialPageRoute(
            builder: (context) => const DetailScreen(),
            settings: settings,
          );
        }
        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const NotFoundScreen(),
        );
      },
    );
  }
}