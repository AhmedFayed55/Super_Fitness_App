import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';

abstract interface class ExerciseRepo {
  Future<ApiResult<List<ExerciseEntity>>> getAllExercisesByDifficulty(
    String muscleId,
    String difficultyId,
  );
  Future<ApiResult<List<DifficultyLevelEntity>>> getExerciseDifficultesByMuscle(
    String primeMoverMuscleId,
  );
}
