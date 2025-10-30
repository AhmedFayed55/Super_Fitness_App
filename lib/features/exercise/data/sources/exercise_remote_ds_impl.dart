import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/get_all_exerecises_response.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_difficulty_level/get_difficulty_level_respone.dart';
import 'package:super_fitness_app/features/exercise/data/sources/exercise_remote_ds.dart';

@Injectable(as: ExerciseRemoteDataSource)
class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {
  final ApiServices _apiServices;

  ExerciseRemoteDataSourceImpl(this._apiServices);
  @override
  Future<GetAllExerecisesResponse> getAllExercisesByDifficulty(
    String muscleId,
    String difficultyId,
  ) async {
    return await _apiServices.getAllExercisesByDifficulty(
      muscleId,
      difficultyId,
    );
  }

  @override
  Future<GetDifficultyLevelRespone> getDifficultyLevelsByPrimeMover(
    String primeMoverMuscleId,
  )async {
    return await _apiServices.getDifficultyLevelsByPrimeMover(
      primeMoverMuscleId,
    );
  }
}
