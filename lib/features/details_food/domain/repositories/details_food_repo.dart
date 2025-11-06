import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/details_food/domain/entities/details_food_entity.dart';

abstract interface class DetailsFoodRepo {
  Future<ApiResult<DetailsFoodEntity>> detailsFoodRepo(String mealId);
}
