import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/network_constants.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';

import '../../features/food/data/models/meals_by_category_response_dto.dart';

part 'api_services_meals.g.dart';

@RestApi()
@injectable
abstract class MealsApiServices {
  @factoryMethod
  factory MealsApiServices(@Named(NetworkConstants.mealsApiClient) Dio dio) =
      _MealsApiServices;

  @GET(EndPoints.recommendationForYou)
  Future<MealsCategoriesResponse> recommendationForYou();

  @GET(EndPoints.getMealsByCategory)
  Future<MealsByCategoryResponseDto> filterMealsByCategory(
    @Query(NetworkConstants.mealsCategoryQueryParam) String category,
  );
}
