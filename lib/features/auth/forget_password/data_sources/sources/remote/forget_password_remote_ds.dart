import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/forget_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/reset_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/verify_reset_code_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/forget_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/reset_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/verify_reset_code_response_dto.dart';

abstract interface class ForgetPasswordRemoteDs {
  Future<ForgetPasswordResponseDto> forgetPassword(
    ForgetPasswordRequestDto request,
  );

  Future<VerifyResetCodeResponseDto> verifyResetCode(
    VerifyResetCodeRequestDto request,
  );
  Future<ResetPasswordResponseDto> resetPassword(
    ResetPasswordRequestDto request,
  );
}
