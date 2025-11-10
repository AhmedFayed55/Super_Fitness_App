import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';
import 'package:super_fitness_app/features/food/domain/repositories/food_repo.dart';

@injectable
class GetMealsByCategoryUseCase {
  final FoodRepo _repo;
  GetMealsByCategoryUseCase(this._repo);

  Future<ApiResult<List<MealsResponseEntity>>> call(String categoryName) =>
      _repo.getMealsByCategory(categoryName);
}
