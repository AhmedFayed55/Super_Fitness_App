import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/response/user_response_entity.dart';

abstract interface class LoginScreenRepo {
  Future<ApiResult<UserResponseEntity>> login(LoginRequestEntity loginRequest);
}
