import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/upcoming_workouts/muscles_group_id_response_remote_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/upcoming_workouts/muscles_group_id_response_repo.dart';

class MusclesGroupIdResponseRepoImpl implements MusclesGroupIdResponseRepo {
  MusclesGroupIdResponseRemoteDs musclesGroupIdResponseRemoteDs;

  MusclesGroupIdResponseRepoImpl({
    required this.musclesGroupIdResponseRemoteDs,
  });

  @override
  Future<ApiResult<MusclesGroupIdEntity>> getMusclesGroupId(
    String muscleGroupId,
  ) async {
    return await safeApiCall<MusclesGroupIdEntity>(() async {
      var musclesGroupIdResponse = await musclesGroupIdResponseRemoteDs
          .getMusclesGroupId(muscleGroupId);
      var musclesGroupIdEntity = musclesGroupIdResponse.toEntity();
      return musclesGroupIdEntity;
    });
  }
}
