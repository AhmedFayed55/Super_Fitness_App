import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';

abstract interface class GetAllMusclesResponseRepo {
  Future<ApiResult<GetAllMusclesEntity>> getAllMuscles();
}
