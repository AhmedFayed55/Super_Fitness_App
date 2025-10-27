import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/core/network/network_constants.dart';
import 'package:super_fitness_app/features/home_screen/data/models/recommendation_to_day/muscles_random_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @GET(EndPoints.recommendationToDay)
  Future<MusclesRandomResponse> recommendationToDay();

  @GET(EndPoints.upcomingWorkoutsTab)
  Future<GetAllMusclesResponse> upcomingWorkoutsTab();

  @GET(EndPoints.upcomingWorkoutsTabItems)
  Future<MusclesGroupIdResponse> upcomingWorkoutsTabItems(
    @Path("muscleGroupId") String muscleGroupId,
  );
}
