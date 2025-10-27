import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/upcoming_workouts/get_all_muscles_response_repo.dart';

class GetAllMusclesResponseUseCase{
  GetAllMusclesResponseRepo getAllMusclesResponseRepo;

  GetAllMusclesResponseUseCase({required this.getAllMusclesResponseRepo});

  Future<ApiResult<GetAllMusclesEntity>> call() async {
    var result = await getAllMusclesResponseRepo.getAllMuscles();
    return result;
  }
}