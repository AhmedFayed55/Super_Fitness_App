import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/entities/change_pass_entity.dart';

abstract interface class ChangePasswordRepository {
  Future<ApiResult<ChangePasswordEntity>> changePassword(
    ChangePasswordRequest request,
  );
}
