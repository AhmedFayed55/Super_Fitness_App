import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/logout/domain/entities/logout_entity.dart';
import 'package:super_fitness_app/features/auth/logout/domain/repo/logout_repo.dart';

@injectable
class LogoutUseCase {
  final LogoutRepo _logoutRepo;
  LogoutUseCase(this._logoutRepo);
  Future<ApiResult<LogoutEntity>> call() {
    return _logoutRepo.logoutRepo();
  }
}
