import 'package:super_fitness_app/features/popular_training/data_sources/models/request/get_all_exercises_request_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/response/get_all_exercises_response_dto.dart';

abstract interface class PopularTrainingRemoteDs {
  Future<GetAllExercisesResponseDto> getAllExercises(
    GetAllExercisesRequestDto request,
  );
}
