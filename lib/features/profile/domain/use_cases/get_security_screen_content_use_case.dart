import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/profile/domain/entities/local_models_entity/security_roles_config/security_roles_screen_response_dto.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SecurityScreenContentUseCase {
  final ProfileRepo _repo;
  SecurityScreenContentUseCase(this._repo);

  Future<ApiResult<List<SecurityRolesConfigEntity>>> call() =>
      _repo.getSecurityRolesConfigScreenContent();
}
