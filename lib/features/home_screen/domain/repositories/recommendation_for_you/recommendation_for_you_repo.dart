import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';

abstract interface class RecommendationForYouRepo {
  Future<ApiResult<MealsCategoriesEntity>> recommendationForYou();
}
