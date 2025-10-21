import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/response/user_response_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/repositories/login_screen_repo.dart';

class LoginUseCase {
  final LoginScreenRepo _repo;
  LoginUseCase(this._repo);

  Future<ApiResult<UserResponseEntity>> invoke(
    LoginRequestEntity loginRequest,
  ) => _repo.login(loginRequest);
}
