import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/upcoming_workouts/muscles_group_id_response_repo.dart';

class MusclesGroupIdResponseUseCase{
  MusclesGroupIdResponseRepo musclesGroupIdResponseRepo;

  MusclesGroupIdResponseUseCase({required this.musclesGroupIdResponseRepo});

  Future<ApiResult<MusclesGroupIdEntity>> call(String muscleGroupId) async {
    var result = await musclesGroupIdResponseRepo.getMusclesGroupId(muscleGroupId);
    return result;
  }
}