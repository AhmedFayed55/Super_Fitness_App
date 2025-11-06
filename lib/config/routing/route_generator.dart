import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/details_food/presentation/pages/details_food_screen.dart';
import '../../features/auth/login/presentation/pages/login_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutes.detailsMeal:
        return MaterialPageRoute(
          builder: (context) => const DetailsFoodScreen(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
