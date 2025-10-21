import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/features/auth/login/data/data_sources/login_screen_ds.dart';
import 'package:super_fitness_app/features/auth/login/data/models/request/login_request_dto.dart';
import 'package:super_fitness_app/features/auth/login/data/models/response/login_response_dto.dart';
import '../../../../../core/network/api_services.dart';

@Injectable(as: LoginScreenDataSource)
class LoginScreenDataSourceImpl implements LoginScreenDataSource {
  final ApiServices _apiServices;
  LoginScreenDataSourceImpl(this._apiServices);

  @override
  Future<LoginResponseDto> login(LoginRequestDto loginRequest) =>
      _apiServices.login(loginRequest);
}
