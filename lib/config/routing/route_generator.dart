import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/pages/edit_profile.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/pages/weight_goal_activity_edit.dart';
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
      case AppRoutes.weightGoalActivityEdit:
        var viewModel = settings.arguments as EditProfileCubit;

        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: viewModel,

            child: const WeightGoalActivityEdit(),
          ),
        );

      case AppRoutes.editProfile:
        var user = settings.arguments as UserEntity;
        return MaterialPageRoute(builder: (context) => EditProfile(user: user));

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
