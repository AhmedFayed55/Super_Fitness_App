import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/auth/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserDataUseCase {
  final ProfileRepo _repo;
  GetUserDataUseCase(this._repo);

  Future<ApiResult<UserDataResponseEntity>> call() => _repo.getUserData();
}
