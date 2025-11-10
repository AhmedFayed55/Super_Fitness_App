import 'package:super_fitness_app/features/exercise/data/mapper/exercise_mapper.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/response/get_all_exercises_response_dto.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/response/get_all_exercises_response_entity.dart';

extension PopularTrainingResponseMapper on GetAllExercisesResponseDto {
  GetAllExercisesResponseEntity toEntity() {
    return GetAllExercisesResponseEntity(
      message: message ?? 'success',
      totalExercises: totalExercises ?? 0,
      totalPages: totalPages ?? 0,
      currentPage: currentPage ?? 1,
      exercises: exercises?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
