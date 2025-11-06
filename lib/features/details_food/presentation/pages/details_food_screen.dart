import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_event.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_state.dart';
import 'package:super_fitness_app/features/details_food/presentation/manager/details_food_view_model.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_ingredient_widget.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/custom_recommendation_widget.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/video_player_loading_shimmer.dart';
import 'package:super_fitness_app/features/details_food/presentation/widget/video_player_widget.dart';

class DetailsFoodScreen extends StatelessWidget {
  const DetailsFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = getIt<DetailsFoodViewModel>();
    return BlocProvider(
      create: (context) =>
          cubit..doIntent(DetailsDataFoodEvent(idMeal: '52959')),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<DetailsFoodViewModel, DetailsFoodState>(
            builder: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                return Center(child: Text(state.errorMessage));
              }
              return Stack(
                children: [
                  Positioned.fill(child: Image.asset(AppAssets.bgDetailsFood)),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.isLoading
                            ? const VideoPlayerLoadingShimmer()
                            : const VideoPlayerWidget(),
                        const CustomIngredientWidget(),
                        const CustomRecommendationWidget(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
