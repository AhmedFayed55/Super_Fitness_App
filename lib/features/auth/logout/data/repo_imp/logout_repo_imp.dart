import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/services/token_service.dart';
import 'package:super_fitness_app/features/auth/logout/data/data_source/logout_ds.dart';
import 'package:super_fitness_app/features/auth/logout/data/mapper/to_logout_entity.dart';
import 'package:super_fitness_app/features/auth/logout/domain/entities/logout_entity.dart';
import 'package:super_fitness_app/features/auth/logout/domain/repo/logout_repo.dart';

@Injectable(as: LogoutRepo)
class LogoutRepoImp implements LogoutRepo {
  final LogoutDataSource _logoutDataSource;
  final TokenService _tokenService;
  LogoutRepoImp(this._logoutDataSource, this._tokenService);
  @override
  Future<ApiResult<LogoutEntity>> logoutRepo() {
    return safeApiCall(() async {
      var response = await _logoutDataSource.logoutDataSource();
      _tokenService.deleteToken();
      return response.toEntity();
    });
  }
}
