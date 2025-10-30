import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_event.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_state.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_view_model.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/food_tab_bar_list.dart';

class FoodTabBarBlocBuilder extends StatefulWidget {
  const FoodTabBarBlocBuilder({super.key, required this.index});
  final int index;

  @override
  State<FoodTabBarBlocBuilder> createState() => _FoodTabBarBlocBuilderState();
}

class _FoodTabBarBlocBuilderState extends State<FoodTabBarBlocBuilder> {
  late int currentIndex = widget.index;
  bool _initialMealsLoaded = false; // 👈 عشان نمنع التكرار

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodScreenViewModel, FoodScreenState>(
      builder: (context, state) {
        if (state.isCategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.categoriesError != null) {
          return Center(child: Text(state.categoriesError!));
        } else if (state.categories != null && state.categories!.isNotEmpty) {
          // 👇 نستدعي أول مرة فقط
          if (!_initialMealsLoaded) {
            _initialMealsLoaded = true;
            context.read<FoodScreenViewModel>().doIntent(
              GetMealsByCategoryEvent(state.categories!.first.strCategory),
            );
          }

          return FoodTabBarList(
            currentIndex: currentIndex,
            onIndexChanged: (index) {
              setState(() {
                currentIndex = index;
              });
              context.read<FoodScreenViewModel>().doIntent(
                GetMealsByCategoryEvent(state.categories![index].strCategory),
              );
            },
            categories: state.categories!,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
