import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_event.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_ingredient_widget.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_recommendation_widget.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/video_player_widget.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';

class DetailsFoodScreen extends StatelessWidget {
  const DetailsFoodScreen({super.key,required this.mealId});
// final List<MealsResponseEntity> meals; 
 final String mealId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DetailsFoodViewModel>()
            ..doIntent(DetailsDataFoodEvent(idMeal: mealId)),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<DetailsFoodViewModel, DetailsFoodState>(
            builder: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                return Center(child: Text(state.errorMessage));
              }
              return Skeletonizer(
                enabled: state.isLoading,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(AppAssets.bgDetailsFood),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VideoPlayerWidget(),
                        CustomIngredientWidget(),
                        CustomRecommendationWidget(),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
