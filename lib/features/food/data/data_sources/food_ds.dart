import 'package:super_fitness_app/features/food/data/models/meals_by_category_response_dto.dart';

abstract interface class FoodDataSource {
  Future<MealsByCategoryResponseDto> getMealsByCategory(String categoryName);
}
