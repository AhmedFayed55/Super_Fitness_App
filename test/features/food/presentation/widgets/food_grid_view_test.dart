import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/food_grid_view.dart';
import 'package:super_fitness_app/features/food/presentation/widgets/meal_grid_view_item_widget.dart';

void main() {
  group('FoodGridView Widget Tests', () {
    final mockMeals = List.generate(
      4,
      (index) => MealsResponseEntity(
        idMeal: '$index',
        strMeal: 'Meal $index',
        strMealThumb: 'https://example.com/image_$index.jpg',
      ),
    );

    testWidgets('get correct number of meal items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: FoodGridView(meals: mockMeals)),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      for (final meal in mockMeals) {
        expect(find.text(meal.strMeal), findsOneWidget);
      }

      expect(find.byType(GridView), findsOneWidget);
      expect(
        find.byType(MealGridViewItemWidget),
        findsNWidgets(mockMeals.length),
      );
    });

    testWidgets('shows nothing when meals list is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: FoodGridView(meals: [])),
        ),
      );

      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(MealGridViewItemWidget), findsNothing);
    });
  });
}
