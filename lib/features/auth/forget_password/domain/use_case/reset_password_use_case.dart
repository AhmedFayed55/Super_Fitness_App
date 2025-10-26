import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';

@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<ApiResult<ResetPasswordResponseEntity>> invoke(
    ResetPasswordRequestEntity request,
  ) {
    return _repository.resetPassword(request);
  }
}
