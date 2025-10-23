import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/pages/onboarding_screen.dart';
import '../../features/auth/login/presentation/pages/login_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        );

      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
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
