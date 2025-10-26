import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/pages/activity_screen.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/presentation/pages/goal_screen.dart';
import '../../features/auth/login/presentation/pages/login_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutes.goalScreen:
        return MaterialPageRoute(builder: (context) =>  GoalScreen());

      case AppRoutes.activityScreen:
        return MaterialPageRoute(builder: (context) =>  ActivityScreen());

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
