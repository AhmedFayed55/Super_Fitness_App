import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';
import 'meal_grid_view_item_widget.dart';

class FoodGridView extends StatelessWidget {
  const FoodGridView({super.key, required this.meals});

  final List<MealsResponseEntity> meals;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: screenSize.width * 0.045,
        crossAxisSpacing: screenSize.height * 0.02,
      ),
      itemBuilder: (context, index) {
        return MealGridViewItemWidget(
          title: meals[index].strMeal,
          imagePath: meals[index].strMealThumb,
        );
      },
    );
  }
}
