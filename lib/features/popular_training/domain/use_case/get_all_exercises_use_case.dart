import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/request/get_all_exercises_request_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/response/get_all_exercises_response_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repositories/popular_training_repo.dart';

@injectable
class GetAllExercisesUseCase {
  final PopularTrainingRepository _repository;

  GetAllExercisesUseCase(this._repository);

  Future<ApiResult<GetAllExercisesResponseEntity>> invoke(
    GetAllExercisesRequestEntity request,
  ) {
    return _repository.getAllExercises(request);
  }
}
