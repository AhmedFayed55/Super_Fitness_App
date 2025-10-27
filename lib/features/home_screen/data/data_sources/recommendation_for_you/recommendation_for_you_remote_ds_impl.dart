import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services_meals.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';

import 'recommendation_for_you_remote_ds.dart';

@Injectable(as: RecommendationForYouRemoteDs)
class RecommendationForYouRemoteDsImpl implements RecommendationForYouRemoteDs {
  ApiServicesMeals apiServicesMeals;

  RecommendationForYouRemoteDsImpl({required this.apiServicesMeals});

  @override
  Future<MealsCategoriesResponse> recommendationForYou() async {
    var mealsCategoriesResponse = await apiServicesMeals.recommendationForYou();
    return mealsCategoriesResponse;
  }
}
