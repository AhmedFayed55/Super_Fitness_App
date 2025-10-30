import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_for_you/meals_categories_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_random_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';

abstract interface class HomeRepo {
  Future<ApiResult<MealsCategoriesEntity>> recommendationForYou();
  Future<ApiResult<MusclesRandomEntity>> recommendationToDay();
  Future<ApiResult<GetAllMusclesEntity>> getAllMuscles();
  Future<ApiResult<MusclesGroupIdEntity>> getMusclesGroupId(
    String muscleGroupId,
  );
}
