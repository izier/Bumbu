// lib/app/router/app_router.dart

import 'package:flutter/material.dart';
import '../../features/pantry/presentation/screens/pantry_screen.dart';

class AppRouter {
  static const String pantry = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pantry:
        return MaterialPageRoute(
          builder: (_) => const PantryScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
