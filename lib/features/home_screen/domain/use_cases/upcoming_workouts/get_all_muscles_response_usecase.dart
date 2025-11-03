import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';

@injectable
class GetAllMusclesResponseUseCase {
  final HomeRepo _repo;

  GetAllMusclesResponseUseCase(this._repo);

  Future<ApiResult<GetAllMusclesEntity>> call() async {
    final result = await _repo.getAllMuscles();
    if (result is ApiSuccessResult<GetAllMusclesEntity>) {
      final originalList = result.data.musclesGroupDtoEntity;
      final fullBodyTab = MusclesGroupDtoEntity(
        id: "full_body",
        name: "Full Body",
      );
      final updatedList = [fullBodyTab, ...originalList];
      final updatedResponse = GetAllMusclesEntity(
        message: result.data.message,
        musclesGroupDtoEntity: updatedList,
      );
      return ApiSuccessResult<GetAllMusclesEntity>(data: updatedResponse);
    }
    return result;
  }
}
