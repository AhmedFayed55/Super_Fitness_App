import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
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
  HomeScreen({super.key,required this.onPressed});

  final homeCubit = getIt.get<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = context.width;
    var screenHeight = context.height;
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
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.043,
              MediaQuery.of(context).padding.top,
              screenWidth * 0.043,
              screenHeight * 0.02,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UserProfile(),
                  verticalSpace(24),
                  const CategoryBar(),
                  verticalSpace(24),
                  const RecommendationToDay(),
                  verticalSpace(24),
                  UpcomingWorkoutsTab(onClick: (){
                    if(onPressed != null) {
                      onPressed!();
                    }
                  },),
                  const UpcomingWorkoutsItems(),
                  verticalSpace(24),
                  const RecommendationForYou(),
                  verticalSpace(24),
                  Text("popular training", style: Theme.of(context).textTheme.displaySmall),
                  verticalSpace(8),
                  Popular(),
                  SizedBox(height: 120,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
