import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';

abstract interface class RecommendationToDayRepo {
  Future<ApiResult<MusclesRandomEntity>> recommendationToDay();
}
