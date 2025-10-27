import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/recommendation_for_you/recommendation_for_you_repo.dart';

class RecommendationForYouUseCase {
  RecommendationForYouRepo recommendationForYouRepo;

  RecommendationForYouUseCase({required this.recommendationForYouRepo});

  Future<ApiResult<MealsCategoriesEntity>> call() async {
    var result = await recommendationForYouRepo.recommendationForYou();
    return result;
  }
}
