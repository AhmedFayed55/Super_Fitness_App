import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/response/get_user_data_response_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';

@injectable
class GetUserDataUseCase {
  final SmartCoachRepository _repository;

  GetUserDataUseCase(this._repository);

  Future<ApiResult<GetUserDataResponseEntity>> call() {
    return _repository.getUserData();
  }
}
