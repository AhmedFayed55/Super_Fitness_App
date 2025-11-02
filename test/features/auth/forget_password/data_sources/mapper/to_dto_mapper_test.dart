import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/mapper/to_dto_mapper.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/forget_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/reset_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/verify_reset_code_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/forget_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/verify_reset_code_request_entity.dart';

void main() {
  group('Forget Password Mapper Tests', () {
    test(
      'ForgetPasswordRequestEntity → ForgetPasswordRequestDto mapping should be correct',
      () {
        const mockEntity = ForgetPasswordRequestEntity(
          email: 'user@example.com',
        );

        final result = mockEntity.toDto();

        expect(result, isA<ForgetPasswordRequestDto>());
        expect(result.email, mockEntity.email);
      },
    );

    test(
      'VerifyResetCodeRequestEntity → VerifyResetCodeRequestDto mapping should be correct',
      () {
        const mockEntity = VerifyResetCodeRequestEntity(resetCode: '123456');

        final result = mockEntity.toDto();

        expect(result, isA<VerifyResetCodeRequestDto>());
        expect(result.resetCode, mockEntity.resetCode);
      },
    );

    test(
      'ResetPasswordRequestEntity → ResetPasswordRequestDto mapping should be correct',
      () {
        const mockEntity = ResetPasswordRequestEntity(
          email: 'user@example.com',
          newPassword: 'newPassword123',
        );

        final result = mockEntity.toDto();

        expect(result, isA<ResetPasswordRequestDto>());
        expect(result.email, mockEntity.email);
        expect(result.newPassword, mockEntity.newPassword);
      },
    );
  });
}
