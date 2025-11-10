import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/logout/data/data_source/logout_ds.dart';
import 'package:super_fitness_app/features/auth/logout/data/model/logout_response_dto.dart';

@Injectable(as: LogoutDataSource)
class LogoutDataSourceImp implements LogoutDataSource {
  final ApiServices _apiServices;
  LogoutDataSourceImp(this._apiServices);
  @override
  Future<LogoutResponseDto> logoutDataSource() {
    return _apiServices.logout();
  }
}
