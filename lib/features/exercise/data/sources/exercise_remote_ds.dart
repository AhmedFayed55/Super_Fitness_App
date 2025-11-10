import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/get_all_exerecises_response.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_difficulty_level/get_difficulty_level_respone.dart';

abstract interface class ExerciseRemoteDataSource {
  Future<GetAllExerecisesResponse> getAllExercisesByDifficulty(
    String muscleId,
    String difficultyId,
  );
  Future<GetDifficultyLevelRespone> getDifficultyLevelsByPrimeMover(
    String primeMoverMuscleId,
  );
}
