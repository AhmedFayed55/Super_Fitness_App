import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';

@injectable
class RecommendationToDayUseCase {
  final HomeRepo _repo;

  RecommendationToDayUseCase(this._repo);

  Future<ApiResult<MusclesRandomEntity>> call() => _repo.recommendationToDay();
}
