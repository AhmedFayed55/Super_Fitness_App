import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';

@injectable
class MusclesGroupIdResponseUseCase {
  final HomeRepo _repo;

  MusclesGroupIdResponseUseCase(this._repo);

  Future<ApiResult<MusclesGroupIdEntity>> call(String muscleGroupId) async {
    return await _repo.getMusclesGroupId(muscleGroupId);
  }
}
