import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_event.dart';
import 'package:super_fitness_app/features/food/presentation/manager/food_screen_view_model.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/food_tab_bar_list.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodTabBarBlocBuilder extends StatefulWidget {
  const FoodTabBarBlocBuilder({
    super.key,
    required this.index,
    required this.categories,
  });

  final int index;
  final List<CategoriesEntity> categories;

  @override
  State<FoodTabBarBlocBuilder> createState() => _FoodTabBarBlocBuilderState();
}

class _FoodTabBarBlocBuilderState extends State<FoodTabBarBlocBuilder> {
  late int currentIndex = widget.index;

  @override
  void initState() {
    super.initState();

    if (widget.categories.isNotEmpty) {
      context.read<FoodScreenViewModel>().doIntent(
        GetMealsByCategoryEvent(widget.categories[widget.index].strCategory),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FoodTabBarList(
      currentIndex: currentIndex,
      onIndexChanged: (index) {
        setState(() => currentIndex = index);
        context.read<FoodScreenViewModel>().doIntent(
          GetMealsByCategoryEvent(widget.categories[index].strCategory),
        );
      },
      categories: widget.categories,
    );
  }
}
