import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/mapper/to_entity_mapper.dart';
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

void main() {
  group('Forget Password Mapper (toEntity) Tests', () {
    test(
      'ForgetPasswordRequestDto → ForgetPasswordRequestEntity mapping should be correct',
      () {
        final mockDto = ForgetPasswordRequestDto(email: 'user@example.com');

        final result = mockDto.toEntity();

        expect(result, isA<ForgetPasswordRequestEntity>());
        expect(result.email, mockDto.email);
      },
    );

    test(
      'VerifyResetCodeRequestDto → VerifyResetCodeRequestEntity mapping should be correct',
      () {
        final mockDto = VerifyResetCodeRequestDto(resetCode: '654321');

        final result = mockDto.toEntity();

        expect(result, isA<VerifyResetCodeRequestEntity>());
        expect(result.resetCode, mockDto.resetCode);
      },
    );

    test(
      'ResetPasswordRequestDto → ResetPasswordRequestEntity mapping should be correct',
      () {
        final mockDto = ResetPasswordRequestDto(
          email: 'user@example.com',
          newPassword: 'newPass456',
        );

        final result = mockDto.toEntity();

        expect(result, isA<ResetPasswordRequestEntity>());
        expect(result.email, mockDto.email);
        expect(result.newPassword, mockDto.newPassword);
      },
    );

    test(
      'ForgetPasswordResponseDto → ForgetPasswordResponseEntity mapping should be correct',
      () {
        final mockDto = ForgetPasswordResponseDto(
          message: 'Reset link sent successfully',
          info: 'Check your email',
        );

        final result = mockDto.toEntity();

        expect(result, isA<ForgetPasswordResponseEntity>());
        expect(result.message, mockDto.message);
        expect(result.info, mockDto.info);
      },
    );

    test(
      'VerifyResetCodeResponseDto → VerifyResetCodeResponseEntity mapping should be correct',
      () {
        final mockDto = VerifyResetCodeResponseDto(status: 'Code verified');

        final result = mockDto.toEntity();

        expect(result, isA<VerifyResetCodeResponseEntity>());
        expect(result.status, mockDto.status);
      },
    );

    test(
      'ResetPasswordResponseDto → ResetPasswordResponseEntity mapping should be correct',
      () {
        final mockDto = ResetPasswordResponseDto(
          message: 'Password reset successfully',
          token: 'abc123token',
        );

        final result = mockDto.toEntity();

        expect(result, isA<ResetPasswordResponseEntity>());
        expect(result.message, mockDto.message);
        expect(result.token, mockDto.token);
      },
    );

    test('Null fields in response DTOs should map to default values', () {
      final forgetDto = ForgetPasswordResponseDto(info: null, message: null);
      final verifyDto = VerifyResetCodeResponseDto(status: null);
      final resetDto = ResetPasswordResponseDto(message: null, token: null);

      final forgetEntity = forgetDto.toEntity();
      final verifyEntity = verifyDto.toEntity();
      final resetEntity = resetDto.toEntity();

      expect(forgetEntity.message, 'unknown message');
      expect(forgetEntity.info, 'no info');
      expect(verifyEntity.status, 'unknown status');
      expect(resetEntity.message, 'unknown message');
      expect(resetEntity.token, '');
    });
  });
}
