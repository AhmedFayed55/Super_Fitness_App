import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/forget_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/reset_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/verify_reset_code_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/forget_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/reset_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/verify_reset_code_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/sources/remote/forget_password_remote_ds.dart';

@Injectable(as: ForgetPasswordRemoteDs)
class ForgetPasswordRemoteDsImpl implements ForgetPasswordRemoteDs {
  final ApiServices _apiService;
  ForgetPasswordRemoteDsImpl({required ApiServices apiService})
    : _apiService = apiService;

  @override
  Future<ForgetPasswordResponseDto> forgetPassword(
    ForgetPasswordRequestDto request,
  ) {
    return _apiService.forgotPassword(request);
  }

  @override
  Future<ResetPasswordResponseDto> resetPassword(
    ResetPasswordRequestDto request,
  ) {
    return _apiService.resetPassword(request);
  }

  @override
  Future<VerifyResetCodeResponseDto> verifyResetCode(
    VerifyResetCodeRequestDto request,
  ) {
    return _apiService.verifyCode(request);
  }
}
