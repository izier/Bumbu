// lib/app/router/app_router.dart

import 'package:flutter/material.dart';
import '../../features/activity/presentation/pages/activity_page.dart';

class AppRouter {
  static const String activity = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case activity:
        return MaterialPageRoute(
          builder: (_) => const ActivityPage(),
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
