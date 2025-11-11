import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/profile/data/data_sources/remote_ds/profile_remote_ds.dart';
import 'package:super_fitness_app/features/auth/profile/data/models/logged_user_data/logged_user_data_response_dto.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiServices _apiServices;
  ProfileRemoteDataSourceImpl(this._apiServices);

  @override
  Future<LoggedUserDataResponseDto> getUserData() => _apiServices.getUserData();
}
