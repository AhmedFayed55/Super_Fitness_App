import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/change_password/data/data_sources/remote/change_pass_remote_ds.dart';
import 'package:super_fitness_app/features/auth/change_password/data/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/entities/change_pass_entity.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/repositories/change_pass_repo.dart';

@Injectable(as: ChangePasswordRepository)
class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordRemoteDataSource _dataSource;

  ChangePasswordRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<ChangePasswordEntity>> changePassword(
    ChangePasswordRequest request,
  ) async {
    return await safeApiCall<ChangePasswordEntity>(() async {
      final response = await _dataSource.changePassword(request);
      final entity = response.toEntity();
      return entity;
    });
  }
}
