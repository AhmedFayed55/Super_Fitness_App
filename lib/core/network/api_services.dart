import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/network_constants.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/forget_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/reset_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/verify_reset_code_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/forget_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/reset_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/verify_reset_code_response_dto.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_response_model.dart';
import 'package:super_fitness_app/features/auth/login/data/models/response/login_response_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/request/get_all_exercises_request_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/response/get_all_exercises_response_dto.dart';
import '../../features/auth/login/data/models/request/login_request_dto.dart';
import '../../features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import '../../features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import '../../features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/get_all_exerecises_response.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_difficulty_level/get_difficulty_level_respone.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @POST(EndPoints.forgotPassword)
  Future<ForgetPasswordResponseDto> forgotPassword(
    @Body() ForgetPasswordRequestDto body,
  );

  @POST(EndPoints.verifyResetCode)
  Future<VerifyResetCodeResponseDto> verifyCode(
    @Body() VerifyResetCodeRequestDto body,
  );

  @PUT(EndPoints.resetPassword)
  Future<ResetPasswordResponseDto> resetPassword(
    @Body() ResetPasswordRequestDto body,
  );
  @POST(EndPoints.login)
  Future<LoginResponseDto> login(@Body() LoginRequestDto loginRequest);

  @POST(EndPoints.register)
  Future<RegisterResponseModel> register(
    @Body() RegisterRequestModel registerRequestModel,
  );
  @GET(EndPoints.recommendationToDay)
  Future<MusclesRandomResponse> recommendationToDay();

  @GET(EndPoints.upcomingWorkoutsTab)
  Future<GetAllMusclesResponse> upcomingWorkoutsTab();

  @GET(EndPoints.upcomingWorkoutsTabItems)
  Future<MusclesGroupIdResponse> upcomingWorkoutsTabItems(
    @Path("muscleGroupId") String muscleGroupId,
  );

  @GET(EndPoints.allExercises)
  Future<GetAllExercisesResponseDto> getAllExercises(
    @Queries() GetAllExercisesRequestDto request,
  );
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
