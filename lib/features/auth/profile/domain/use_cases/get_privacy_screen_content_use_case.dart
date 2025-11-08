import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/profile/domain/entities/local_models_entity/privacy_and_security/privacy_and_security_screen_response_dto.dart';
import 'package:super_fitness_app/features/auth/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPrivacyScreenContentUseCase {
  final ProfileRepo _repo;
  GetPrivacyScreenContentUseCase(this._repo);

  Future<ApiResult<List<PrivacyAndSecurityScreenResponseEntity>>> call() =>
      _repo.getPrivacyAndSecurityScreenContent();
}
