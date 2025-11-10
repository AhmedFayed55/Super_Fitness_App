import 'package:super_fitness_app/features/auth/logout/data/model/logout_response_dto.dart';

abstract interface class LogoutDataSource {
  Future<LogoutResponseDto> logoutDataSource();
}
