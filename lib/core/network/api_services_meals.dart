import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/network_constants.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';

part 'api_services_meals.g.dart';

@RestApi()
@injectable
abstract class ApiServicesMeals {
  @factoryMethod
  factory ApiServicesMeals(@Named('dioMeals') Dio dio) = _ApiServicesMeals;

  @GET(EndPoints.recommendationForYou)
  Future<MealsCategoriesResponse> recommendationForYou();
}
