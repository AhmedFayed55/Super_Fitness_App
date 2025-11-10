import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:super_fitness_app/features/auth/login/presentation/pages/login_screen.dart';
import 'package:super_fitness_app/features/auth/profile/presentation/pages/content_screen.dart';
import 'package:super_fitness_app/features/auth/profile/presentation/pages/profile_screen.dart';
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

      case AppRoutes.contentScreen:
        final args = settings.arguments as ContentType;
        return MaterialPageRoute(builder: (context) => ContentScreen(type: args));

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
