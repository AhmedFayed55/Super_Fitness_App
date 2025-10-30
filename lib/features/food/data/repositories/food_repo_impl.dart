import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/food/data/data_sources/food_ds.dart';
import 'package:super_fitness_app/features/food/data/models/mapper/to_meals_entity_mapper.dart';
import 'package:super_fitness_app/features/food/domain/entities/meals_response_entity.dart';
import 'package:super_fitness_app/features/food/domain/repositories/food_repo.dart';

@Injectable(as: FoodRepo)
class FoodRepoImpl implements FoodRepo {
  final FoodDataSource _dataSource;
  FoodRepoImpl(this._dataSource);

  @override
  Future<ApiResult<List<MealsResponseEntity>>> getMealsByCategory(
    String categoryName,
  ) {
    return safeApiCall(() async {
      final response = await _dataSource.getMealsByCategory(categoryName);
      final meals = response.meals;

      if (meals == null) return <MealsResponseEntity>[];
      return meals.map((meal) => meal.toEntity()).toList();
    });
  }
}
