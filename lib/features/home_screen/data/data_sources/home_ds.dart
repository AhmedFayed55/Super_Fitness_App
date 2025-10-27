import 'package:super_fitness_app/features/home_screen/data/models/recommendation_for_you/meals_categories_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';

abstract interface class HomeDataSource {
  Future<MealsCategoriesResponse> recommendationForYou();
  Future<MusclesRandomResponse> recommendationToDay();
  Future<GetAllMusclesResponse> getAllMuscles();
  Future<MusclesGroupIdResponse> getMusclesGroupId(String muscleGroupId);
}
