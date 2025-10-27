import 'package:super_fitness_app/features/home_screen/data/models/upcoming_workouts/get_all_muscles_response.dart';

abstract interface class GetAllMusclesResponseRemoteDs {
  Future<GetAllMusclesResponse> getAllMuscles();
}
