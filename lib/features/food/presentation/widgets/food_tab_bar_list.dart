import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/food_tab_bar.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/categories_entity.dart';

class FoodTabBarList extends StatelessWidget {
  const FoodTabBarList({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.categories,
  });
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  final List<CategoriesEntity> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.height * 0.04,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => FoodTabBar(
          label: categories[index].strCategory,
          isSelected: currentIndex == index,
          onTap: () => onIndexChanged(index),
        ),
      ),
    );
  }
}
