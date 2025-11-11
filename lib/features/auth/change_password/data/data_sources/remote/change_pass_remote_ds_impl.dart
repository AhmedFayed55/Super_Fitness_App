import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_pass_response.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';
import 'change_pass_remote_ds.dart';

@Injectable(as: ChangePasswordRemoteDataSource)
class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  final ApiServices _apiServices;

  ChangePasswordRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ChangePasswordResponse> changePassword(
    ChangePasswordRequest request,
  ) async {
    var changePasswordResponse = await _apiServices.changePassword(request);
    return changePasswordResponse;
  }
}
