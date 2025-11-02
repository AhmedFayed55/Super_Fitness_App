import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/core/network/api_services_meals.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/home_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';

@Injectable(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final ApiServices _apiServices;
  final MealsApiServices _mealsApiServices;
  HomeDataSourceImpl(this._apiServices, this._mealsApiServices);

  @override
  Future<GetAllMusclesResponse> getAllMuscles() =>
      _apiServices.upcomingWorkoutsTab();

  @override
  Future<MusclesGroupIdResponse> getMusclesGroupId(String muscleGroupId) =>
      _apiServices.upcomingWorkoutsTabItems(muscleGroupId);

  @override
  Future<MealsCategoriesResponse> recommendationForYou() =>
      _mealsApiServices.recommendationForYou();

  @override
  Future<MusclesRandomResponse> recommendationToDay() =>
      _apiServices.recommendationToDay();
}
