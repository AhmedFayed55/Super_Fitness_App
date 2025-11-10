import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/repo/exercise_repo.dart';

@injectable
class GetExercisesDifficultesByMuscleUsecase {
  final ExerciseRepo exerciseRepo;
  GetExercisesDifficultesByMuscleUsecase({required this.exerciseRepo});

  Future<ApiResult<List<DifficultyLevelEntity>>> invoke(
    String primeMoverMuscleId,
  ) => exerciseRepo.getExerciseDifficultesByMuscle(primeMoverMuscleId);
}
