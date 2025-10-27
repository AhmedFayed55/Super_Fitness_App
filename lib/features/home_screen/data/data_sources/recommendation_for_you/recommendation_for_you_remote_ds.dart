import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';

abstract interface class RecommendationForYouRemoteDs {
  Future<MealsCategoriesResponse> recommendationForYou();
}
