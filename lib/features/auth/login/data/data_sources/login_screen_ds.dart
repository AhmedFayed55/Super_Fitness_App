import 'package:super_fitness_app/features/auth/login/data/models/request/login_request_dto.dart';
import 'package:super_fitness_app/features/auth/login/data/models/response/login_response_dto.dart';

abstract interface class LoginScreenDataSource {
  Future<LoginResponseDto> login(LoginRequestDto loginRequest);
}
