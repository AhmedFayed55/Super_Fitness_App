import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/get_all_muscles_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/repositories/home_repo.dart';

@injectable
class GetAllMusclesResponseUseCase {
  final HomeRepo _repo;

  GetAllMusclesResponseUseCase(this._repo);

  Future<ApiResult<GetAllMusclesEntity>> call() => _repo.getAllMuscles();
}
