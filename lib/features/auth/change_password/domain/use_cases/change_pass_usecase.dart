import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/entities/change_pass_entity.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/repositories/change_pass_repo.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepository _repo;

  ChangePasswordUseCase(this._repo);

  Future<ApiResult<ChangePasswordEntity>> call(
    ChangePasswordRequest request,
  ) async {
    return await _repo.changePassword(request);
  }
}
