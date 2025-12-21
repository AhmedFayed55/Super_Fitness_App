import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_event.dart';
import 'package:super_fitness_app/features/home_screen/presentation/manager/home_view_model.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/category_bar.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/recommendation_for_you.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/recommendation_to_day.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/upcoming_workouts_items.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/upcoming_workouts_tab.dart';
import 'package:super_fitness_app/features/home_screen/presentation/widgets/user_profile.dart';
import 'package:super_fitness_app/features/popular_training/presentation/pages/popular.dart';

class HomeScreen extends StatelessWidget {
  final Function? onPressed;
  // final UserDataResponseEntity? user;
  HomeScreen({super.key,required this.onPressed,});

  final homeCubit = getIt.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit..doIntent(GetAllHomeDataEvent()),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(AppAssets.homeBackground),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const UserProfile(),
                  verticalSpace(24),
                  const CategoryBar(),
                  verticalSpace(24),
                  const RecommendationToDay(),
                  verticalSpace(24),
                   UpcomingWorkoutsTab(onClicked: () {
                     if(onPressed != null) {
                       onPressed!();
                     }
                  },),
                  const UpcomingWorkoutsItems(),
                  verticalSpace(24),
                  const RecommendationForYou(),
                  verticalSpace(24),
                  Popular(),
                  verticalSpace(120),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
