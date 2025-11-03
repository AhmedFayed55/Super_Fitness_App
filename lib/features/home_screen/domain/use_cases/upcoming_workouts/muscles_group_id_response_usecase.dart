import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_id_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';

@injectable
class MusclesGroupIdResponseUseCase {
  final HomeRepo _repo;

  MusclesGroupIdResponseUseCase(this._repo);

  Future<ApiResult<MusclesGroupIdEntity>> call(String muscleGroupId) async {
    // if(muscleGroupId == "full_body"){
    //   final allMuscles = await _repo.getAllMuscles();
    //   if(allMuscles is ApiSuccessResult<GetAllMusclesEntity>){
    //     final List<MusclesGroupIdEntity>  allItems  = [];
    //     for(final group in allMuscles.data.musclesGroupDtoEntity) {
    //       var result = await _repo.getMusclesGroupId(group.id);
    //       if(result is ApiSuccessResult<MusclesGroupIdEntity>){
    //         list.add(result);
    //       }
    //     }
    //   }
    // }
    return await _repo.getMusclesGroupId(muscleGroupId);
  }
}
