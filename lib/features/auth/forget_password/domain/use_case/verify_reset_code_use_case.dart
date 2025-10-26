import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/verify_reset_code_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/verify_reset_code_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';

@injectable
class VerifyResetCodeUseCase {
  final ForgetPasswordRepository _repository;

  VerifyResetCodeUseCase(this._repository);

  Future<ApiResult<VerifyResetCodeResponseEntity>> invoke(
    VerifyResetCodeRequestEntity request,
  ) {
    return _repository.verifyResetCode(request);
  }
}
