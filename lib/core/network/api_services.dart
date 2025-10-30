import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/network_constants.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/get_all_exerecises_response.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_difficulty_level/get_difficulty_level_respone.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @GET(EndPoints.exercises)
  Future<GetAllExerecisesResponse> getAllExercisesByDifficulty(
    @Query(NetworkConstants.primeMoverMuscleId) String muscleId,
    @Query(NetworkConstants.difficultyLevelId) String difficultyId,
  );

  @GET(EndPoints.difficultyLevels)
  Future<GetDifficultyLevelRespone> getDifficultyLevelsByPrimeMover(
    @Query(NetworkConstants.primeMoverMuscleId) String primeMoverMuscleId,
  );
}
