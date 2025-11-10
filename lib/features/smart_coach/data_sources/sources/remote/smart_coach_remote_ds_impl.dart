import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/models/response/get_user_data_response_dto.dart';
import 'package:super_fitness_app/features/smart_coach/data_sources/sources/remote/smart_coach_remote_ds.dart';

@Injectable(as: SmartCoachRemoteDs)
class SmartCoachRemoteDsImpl implements SmartCoachRemoteDs {
  final ApiServices _apiService;

  SmartCoachRemoteDsImpl({required ApiServices apiService})
    : _apiService = apiService;

  @override
  Future<GetUserDataResponseDto> getUserData() {
    return _apiService.getUserData();
  }
}
