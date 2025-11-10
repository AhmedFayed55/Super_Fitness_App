import 'package:super_fitness_app/features/smart_coach/data_sources/models/response/get_user_data_response_dto.dart';

abstract interface class SmartCoachRemoteDs {
  Future<GetUserDataResponseDto> getUserData();
}
