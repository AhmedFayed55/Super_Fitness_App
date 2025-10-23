import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/forget_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/reset_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/verify_reset_code_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/forget_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/verify_reset_code_request_entity.dart';

extension ForgetPasswordRequestDtoMapper on ForgetPasswordRequestEntity {
  ForgetPasswordRequestDto toDto() {
    return ForgetPasswordRequestDto(email: email);
  }
}

extension VerifyResetCodeRequestDtoMapper on VerifyResetCodeRequestEntity {
  VerifyResetCodeRequestDto toDto() {
    return VerifyResetCodeRequestDto(resetCode: resetCode);
  }
}

extension ResetPasswordRequestDtoMapper on ResetPasswordRequestEntity {
  ResetPasswordRequestDto toDto() {
    return ResetPasswordRequestDto(email: email, newPassword: newPassword);
  }
}
