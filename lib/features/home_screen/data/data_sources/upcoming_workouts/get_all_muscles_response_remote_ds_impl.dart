import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';

import 'get_all_muscles_response_remote_ds.dart';

@Injectable(as: GetAllMusclesResponseRemoteDs)
class GetAllMusclesResponseRemoteDsImpl
    implements GetAllMusclesResponseRemoteDs {
  ApiServices apiServices;

  GetAllMusclesResponseRemoteDsImpl({required this.apiServices});

  @override
  Future<GetAllMusclesResponse> getAllMuscles() async {
    var getAllMusclesResponse = await apiServices.upcomingWorkoutsTab();
    return getAllMusclesResponse;
  }
}
