import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/muscles_group_id_response.dart';

abstract interface class MusclesGroupIdResponseRemoteDs {
  Future<MusclesGroupIdResponse> getMusclesGroupId(String muscleGroupId);
}
