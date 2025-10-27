import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/recommendation_to_day/recommendation_to_day_repo.dart';

class RecommendationToDayUseCase {
  RecommendationToDayRepo recommendationToDayRepo;

  RecommendationToDayUseCase({required this.recommendationToDayRepo});

  Future<ApiResult<MusclesRandomEntity>> call() async {
    var result = await recommendationToDayRepo.recommendationToDay();
    return result;
  }
}
