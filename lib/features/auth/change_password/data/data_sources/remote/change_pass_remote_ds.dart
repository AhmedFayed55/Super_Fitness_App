import 'package:super_fitness_app/features/auth/change_password/data/models/change_pass_response.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';

abstract interface class ChangePasswordRemoteDataSource {
  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request);
}
