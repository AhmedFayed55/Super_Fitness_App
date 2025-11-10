import 'package:super_fitness_app/features/popular_training/data_sources/models/request/get_all_exercises_request_dto.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/request/get_all_exercises_request_entity.dart';

extension PopularTrainingRequestMapper on GetAllExercisesRequestEntity {
  GetAllExercisesRequestDto toDto() {
    return GetAllExercisesRequestDto(page: page, limit: limit);
  }
}
