import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/repo/exercise_repo.dart';

@injectable
class GetAllExercisesByDifficultyUsecase {
  final ExerciseRepo exerciseRepo;
  GetAllExercisesByDifficultyUsecase(this.exerciseRepo);

  Future<ApiResult<List<ExerciseEntity>>> invoke(
    String muscleId,
    String difficultyId,
  ) => exerciseRepo.getAllExercisesByDifficulty(muscleId, difficultyId);
}
