import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_state.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_view_model.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/food_grid_view.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/food_screen_app_bar.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/food_tab_bar_builder.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_entity.dart';

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
                      const FoodScreenAppBar(),
                      verticalSpace(height * 0.039),
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
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
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
