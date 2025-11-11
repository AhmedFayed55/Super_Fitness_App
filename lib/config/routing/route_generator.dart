import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/details_food/presentation/pages/details_food_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:super_fitness_app/features/auth/login/presentation/pages/login_screen.dart';
import 'package:super_fitness_app/features/auth/profile/presentation/pages/content_screen.dart';
import 'package:super_fitness_app/features/auth/logout/presentation/pages/logout_screen.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/manager/cubit/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/pages/edit_profile.dart';
import 'package:super_fitness_app/features/edit-profile/presentation/pages/weight_goal_activity_edit.dart';
import 'package:super_fitness_app/core/utils/constants.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/auth/change_password/presentation/pages/change_password_screen.dart';
import 'package:super_fitness_app/features/app_sections/app_sections.dart';
import 'package:super_fitness_app/features/onBoarding/presentation/pages/onboarding_screen.dart';
import 'package:super_fitness_app/features/workouts/presentation/pages/workouts_screen.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/pages/chat_screen.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/view/chat_conversation.dart';
import 'package:super_fitness_app/features/food/presentation/pages/food_screen.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/presentation/pages/home_screen.dart';
import 'app_routes.dart';
import '../../features/exercise/presentation/pages/exercise_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRoutes.appSections:
        return MaterialPageRoute(builder: (context) => const AppSections());
      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        );
      case AppRoutes.logout:
        return MaterialPageRoute(builder: (context) => const LogoutScreen());

      case AppRoutes.contentScreen:
        final args = settings.arguments as ContentType;
        return MaterialPageRoute(
          builder: (context) => ContentScreen(type: args),
        );
      case AppRoutes.chat:
        return MaterialPageRoute(builder: (context) => const ChatScreen());
      case AppRoutes.chatConversation:
        return MaterialPageRoute(
          builder: (context) => const ChatConversationView(),
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
        var data = settings.arguments as UserDataResponseEntity;
        var user = UserEntity(
          id: data.id,
          firstName: data.firstName,
          lastName: data.lastName,
          email: data.email,
          gender: data.gender,
          age: data.age.toInt(),
          weight: data.weight.toInt(),
          height: data.height.toInt(),
          activityLevel: ActivityLevel.fromRspone(
            data.activityLevel,
          ).displayName,
          goal: data.goal,
          photo: data.photo,
          createdAt: DateTime.parse(data.createdAt),
        );
        log(user.toString());

        return MaterialPageRoute(builder: (context) => EditProfile(user: user));

      case AppRoutes.foodScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final int? index = args['index'];
        final List<CategoriesEntity>? list = args['list'];
        return MaterialPageRoute(
          builder: (context) => FoodScreen(index: index, categories: list),
        );

      case AppRoutes.workouts:
        return MaterialPageRoute(builder: (context) => const WorkoutsScreen());

      case AppRoutes.pTExercise:
        var args = settings.arguments;

        var exercises =
            (args as Map<String, dynamic>)[AppConstants.exercises]
                as List<ExerciseEntity>;
        var difficulties =
            (args)[AppConstants.difficulties] as List<DifficultyLevelEntity>;

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
          builder: (context) => ExerciseScreen.byMuscleId(muscleId: id),
        );

      case AppRoutes.changePassword:
        return MaterialPageRoute(
          builder: (context) => const ChangePasswordScreen(),
        );

      case AppRoutes.detailsMeal:
        final args = settings.arguments as Map<String, dynamic>;
        final id = args[AppConstants.mealId] ?? '';
        final mealList = args[AppConstants.mealList];
        return MaterialPageRoute(
          builder: (context) => DetailsFoodScreen(mealId: id, meals: mealList),
        );

      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());

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
