import 'package:super_fitness_app/features/popular_training/domain/entities/exercise_entity.dart';

class GetAllExercisesResponseEntity {
  final String message;
  final int totalExercises;
  final int totalPages;
  final int currentPage;
  final List<ExerciseEntity> exercises;

  const GetAllExercisesResponseEntity({
    required this.message,
    required this.totalExercises,
    required this.totalPages,
    required this.currentPage,
    required this.exercises,
  });
}
