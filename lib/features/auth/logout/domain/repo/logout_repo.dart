import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/logout/domain/entities/logout_entity.dart';

abstract interface class LogoutRepo {
  Future<ApiResult<LogoutEntity>> logoutRepo();
}
