import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_event.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/category_bar.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/recommendation_for_you.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/recommendation_to_day.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/upcoming_workouts.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/user_profile.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final homeCubit = getIt.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit..doIntent(GetAllHomeDataEvent()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            MediaQuery.of(context).padding.top,
            16,
            16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserProfile(),
              verticalSpace(24),
              CategoryBar(),
              verticalSpace(24),
              RecommendationToDay(),
              verticalSpace(24),
              // UpcomingWorkouts(),
              verticalSpace(24),
              RecommendationForYou(),
            ],
          ),
        ),
      ),
    );
  }
}
