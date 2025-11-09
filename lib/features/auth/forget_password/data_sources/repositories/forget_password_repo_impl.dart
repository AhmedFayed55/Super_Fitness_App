import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/mapper/to_dto_mapper.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/sources/remote/forget_password_remote_ds.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/forget_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/verify_reset_code_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/forget_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/verify_reset_code_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';

@Injectable(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordRemoteDs _remoteDataSource;

  ForgetPasswordRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) async {
    return await safeApiCall(() async {
      final response = await _remoteDataSource.forgetPassword(request.toDto());
      return response.toEntity();
    });
  }

  @override
  Future<ApiResult<VerifyResetCodeResponseEntity>> verifyResetCode(
    VerifyResetCodeRequestEntity request,
  ) async {
    return await safeApiCall(() async {
      final response = await _remoteDataSource.verifyResetCode(request.toDto());
      return response.toEntity();
    });
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) async {
    return await safeApiCall(() async {
      final response = await _remoteDataSource.resetPassword(request.toDto());
      return response.toEntity();
    });
  }
}
