import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/request/get_all_exercises_request_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/response/get_all_exercises_response_entity.dart';

abstract interface class PopularTrainingRepository {
  Future<ApiResult<GetAllExercisesResponseEntity>> getAllExercises(
    GetAllExercisesRequestEntity request,
  );
}
