import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/services/token_service.dart';
import 'package:super_fitness_app/features/auth/login/data/data_sources/login_screen_ds.dart';
import 'package:super_fitness_app/features/auth/login/data/models/maper/login_mapers.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/response/user_response_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/repositories/login_screen_repo.dart';

@Injectable(as: LoginScreenRepo)
class LoginScreenRepoImpl implements LoginScreenRepo {
  final LoginScreenDataSource _dataSource;
  final TokenService _tokenService;
  LoginScreenRepoImpl(this._dataSource, this._tokenService);

  @override
  Future<ApiResult<UserResponseEntity>> login(
    LoginRequestEntity loginRequest,
  ) async {
    return await safeApiCall<UserResponseEntity>(() async {
      var dtoRequest = loginRequest.toDto();
      var response = await _dataSource.login(dtoRequest);
      _tokenService.saveToken(response.token!);
      return response.user!.toEntity();
    });
  }
}
