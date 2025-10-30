import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import '../../features/auth/login/presentation/pages/login_screen.dart';
import 'app_routes.dart';
import '../../features/exercise/presentation/pages/exercise_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoutes.pTExercise:
        var args = settings.arguments;

        var exercises =
            (args as Map<String, dynamic>)[AppConstants.exercises] as List<ExerciseEntity>;
        var difficulties =
            (args)[AppConstants.difficulties]
                as List<DifficultyLevelEntity>;

        return MaterialPageRoute(
          builder: (context) => ExerciseScreen.byPreloadedData(
            exercises: exercises,
            difficulties: difficulties,
          ),
        );
      case AppRoutes.exercise:
        var args = settings.arguments;

        String id = args as String;
        return MaterialPageRoute(
          builder: (context) => ExerciseScreen.byMuscleId(muscleId:id),
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