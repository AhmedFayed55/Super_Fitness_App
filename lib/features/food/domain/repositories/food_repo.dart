import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';

abstract interface class FoodRepo {
  Future<ApiResult<List<MealsResponseEntity>>> getMealsByCategory(
    String categoryName,
  );
}
