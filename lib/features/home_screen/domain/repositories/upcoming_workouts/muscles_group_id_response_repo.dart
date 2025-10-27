import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';

abstract interface class MusclesGroupIdResponseRepo {
  Future<ApiResult<MusclesGroupIdEntity>> getMusclesGroupId(
    String muscleGroupId,
  );
}
