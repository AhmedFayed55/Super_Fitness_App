import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';

@injectable
class RecommendationForYouUseCase {
  final HomeRepo _repo;

  RecommendationForYouUseCase(this._repo);

  Future<ApiResult<MealsCategoriesEntity>> call() =>
      _repo.recommendationForYou();
}
