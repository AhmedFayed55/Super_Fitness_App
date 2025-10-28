import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';
import '../../../../core/network/api_results.dart';
import '../../../home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';

@injectable
class GetFoodCategoriesUseCase{
  final HomeRepo _repo;
  GetFoodCategoriesUseCase(this._repo);

  Future<ApiResult<MealsCategoriesEntity>> getFoodCategories() => _repo.recommendationForYou();

}