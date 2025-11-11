import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/forget_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/reset_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/verify_reset_code_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/forget_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/reset_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/verify_reset_code_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/forget_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/verify_reset_code_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/forget_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/verify_reset_code_response_entity.dart';

extension ForgetPasswordResponseMapper on ForgetPasswordResponseDto {
  ForgetPasswordResponseEntity toEntity() {
    return ForgetPasswordResponseEntity(
      message: message ?? 'unknown message',
      info: info ?? 'no info',
    );
  }
}

extension ForgetPasswordRequestMapper on ForgetPasswordRequestDto {
  ForgetPasswordRequestEntity toEntity() {
    return ForgetPasswordRequestEntity(email: email);
  }
}

extension VerifyResetCodeResponseMapper on VerifyResetCodeResponseDto {
  VerifyResetCodeResponseEntity toEntity() {
    return VerifyResetCodeResponseEntity(status: status ?? 'unknown status');
  }
}

extension VerifyResetCodeRequestMapper on VerifyResetCodeRequestDto {
  VerifyResetCodeRequestEntity toEntity() {
    return VerifyResetCodeRequestEntity(resetCode: resetCode);
  }
}

extension ResetPasswordResponseMapper on ResetPasswordResponseDto {
  ResetPasswordResponseEntity toEntity() {
    return ResetPasswordResponseEntity(
      message: message ?? 'unknown message',
      token: token ?? '',
    );
  }
}

extension ResetPasswordRequestMapper on ResetPasswordRequestDto {
  ResetPasswordRequestEntity toEntity() {
    return ResetPasswordRequestEntity(email: email, newPassword: newPassword);
  }
}
