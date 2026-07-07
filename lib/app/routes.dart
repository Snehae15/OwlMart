import 'package:flutter/material.dart';
import 'package:owlmart/app/auth_wrapper.dart';

class AppRoutes {
  static const String initial = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(
          builder: (_) => const AuthWrapper(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
