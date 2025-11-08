import 'package:super_fitness_app/features/auth/profile/data/models/logged_user_data/logged_user_data_response_dto.dart';

abstract interface class ProfileRemoteDataSource{
  Future<LoggedUserDataResponseDto> getUserData();
}