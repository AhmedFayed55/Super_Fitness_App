import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/exercise/data/mapper/exercise_mapper.dart';
import 'package:super_fitness_app/features/exercise/data/sources/exercise_remote_ds.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/repo/exercise_repo.dart';

@Injectable(as: ExerciseRepo)
class ExerciseRepoImpl implements ExerciseRepo {
  final ExerciseRemoteDataSource _exerciseRemoteDataSource;
  ExerciseRepoImpl(this._exerciseRemoteDataSource);
  @override
  Future<ApiResult<List<ExerciseEntity>>> getAllExercisesByDifficulty(
    String muscleId,
    String difficultyId,
  ) {
    return safeApiCall(() async {
      final response = await _exerciseRemoteDataSource
          .getAllExercisesByDifficulty(muscleId, difficultyId);

      return response.exercises!.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<ApiResult<List<DifficultyLevelEntity>>> getExerciseDifficultesByMuscle(
    String primeMoverMuscleId,
  ) {
    return safeApiCall(() async {
      final response = await _exerciseRemoteDataSource
          .getDifficultyLevelsByPrimeMover(primeMoverMuscleId);
      return response.difficultyLevels!.map((e) => e.toEntity()).toList();
    });
  }
}
