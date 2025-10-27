import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';

import 'muscles_group_id_response_remote_ds.dart';

@Injectable(as: MusclesGroupIdResponseRemoteDs)
class MusclesGroupIdResponseRemoteDsImpl
    implements MusclesGroupIdResponseRemoteDs {
  ApiServices apiServices;

  MusclesGroupIdResponseRemoteDsImpl({required this.apiServices});

  @override
  Future<MusclesGroupIdResponse> getMusclesGroupId(String muscleGroupId) async {
    var getAllMusclesResponse = await apiServices.upcomingWorkoutsTabItems(
      muscleGroupId,
    );
    return getAllMusclesResponse;
  }
}
