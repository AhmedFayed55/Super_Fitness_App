import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/data/data_sources/upcoming_workouts/get_all_muscles_response_remote_ds.dart';
import 'package:super_fitness_app/features/home_screen/data/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/upcoming_workouts/get_all_muscles_response_repo.dart';

class GetAllMusclesResponseRepoImpl implements GetAllMusclesResponseRepo {
  GetAllMusclesResponseRemoteDs getAllMusclesResponseRemoteDs;

  GetAllMusclesResponseRepoImpl({required this.getAllMusclesResponseRemoteDs});

  @override
  Future<ApiResult<GetAllMusclesEntity>> getAllMuscles() async {
    return await safeApiCall<GetAllMusclesEntity>(() async {
      var getAllMusclesResponse = await getAllMusclesResponseRemoteDs
          .getAllMuscles();
      var getAllMusclesEntity = getAllMusclesResponse.toEntity();
      return getAllMusclesEntity;
    });
  }
}
