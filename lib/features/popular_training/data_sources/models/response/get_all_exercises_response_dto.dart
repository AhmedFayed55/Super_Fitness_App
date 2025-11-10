import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/exercise_dto.dart';

part 'get_all_exercises_response_dto.g.dart';

@JsonSerializable()
class GetAllExercisesResponseDto {
  final String? message;
  final int? totalExercises;
  final int? totalPages;
  final int? currentPage;
  final List<ExerciseDto>? exercises;

  GetAllExercisesResponseDto({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory GetAllExercisesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllExercisesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllExercisesResponseDtoToJson(this);
}
