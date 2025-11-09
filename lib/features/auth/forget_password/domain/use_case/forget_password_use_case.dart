import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/forget_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/forget_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepository _repository;

  ForgetPasswordUseCase(this._repository);

  Future<ApiResult<ForgetPasswordResponseEntity>> invoke(
    ForgetPasswordRequestEntity request,
  ) {
    return _repository.forgetPassword(request);
  }
}
