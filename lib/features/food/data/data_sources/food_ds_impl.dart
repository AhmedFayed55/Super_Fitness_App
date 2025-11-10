import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services_meals.dart';
import 'package:super_fitness_app/features/food/data/data_sources/food_ds.dart';
import 'package:super_fitness_app/features/food/data/models/meals_by_category_response_dto.dart';

@Injectable(as: FoodDataSource)
class FoodDataSourceImpl implements FoodDataSource {
  final MealsApiServices _apiServices;
  FoodDataSourceImpl(this._apiServices);

  @override
  Future<MealsByCategoryResponseDto> getMealsByCategory(String categoryName) =>
      _apiServices.filterMealsByCategory(categoryName);
}
