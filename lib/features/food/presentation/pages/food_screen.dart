import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_state.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_view_model.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/food_grid_view.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/food_tab_bar_builder.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_entity.dart';
import 'package:super_fitness_app/widgets/product_shimmer_card.dart';
import 'package:super_fitness_app/widgets/custom_app_bar.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key, this.index, this.categories});

  final int? index;
  final List<CategoriesEntity>? categories;

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  late int currentIndex = widget.index ?? 0;

  @override
  Widget build(BuildContext context) {
    final double height = context.height;

    return BlocProvider(
      create: (context) => getIt<FoodScreenViewModel>(),
      child: Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(onTap: () => context.pop()),
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            context.localization.food_recommendation,
            style: context.textTheme.displayLarge,
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppAssets.foodBackground,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: height * 0.049,
                  ),
                  child: Column(
                    children: [
                      FoodTabBarBuilder(
                        index: currentIndex,
                        categories: widget.categories ?? [],
                      ),

                      verticalSpace(height * 0.02),
                      Expanded(
                        child:
                            BlocBuilder<FoodScreenViewModel, FoodScreenState>(
                              builder: (context, state) {
                                if (state.isMealsLoading) {
                                  return const ProductShimmerCard();
                                } else if (state.meals != null &&
                                    state.meals!.isNotEmpty) {
                                  return FoodGridView(meals: state.meals!);
                                } else if (state.meals != null &&
                                    state.meals!.isEmpty) {
                                  return Center(
                                    child: Lottie.asset(
                                      AppAssets.emptyAnimation,
                                    ),
                                  );
                                } else if (state.mealsError != null) {
                                  return Center(child: Text(state.mealsError!));
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
