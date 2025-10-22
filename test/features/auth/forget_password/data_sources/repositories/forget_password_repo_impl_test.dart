import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/forget_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/reset_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/verify_reset_code_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/repositories/forget_password_repo_impl.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/sources/remote/forget_password_remote_ds.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/forget_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/verify_reset_code_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/forget_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/verify_reset_code_response_entity.dart';

import 'forget_password_repo_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordRemoteDs])
void main() {
  late MockForgetPasswordRemoteDs mockRemote;
  late ForgetPasswordRepositoryImpl repo;

  setUp(() {
    mockRemote = MockForgetPasswordRemoteDs();
    repo = ForgetPasswordRepositoryImpl(mockRemote);
  });

  group('forgetPassword', () {
    test('returns success when remote call succeeds', () async {
      const requestEntity = ForgetPasswordRequestEntity(
        email: 'test@example.com',
      );
      final responseDto = ForgetPasswordResponseDto(
        message: 'Success',
        info: 'Reset code sent',
      );

      when(mockRemote.forgetPassword(any)).thenAnswer((_) async => responseDto);

      final result = await repo.forgetPassword(requestEntity);

      expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
      verify(mockRemote.forgetPassword(any)).called(1);
    });

    test('returns error when remote throws', () async {
      const requestEntity = ForgetPasswordRequestEntity(
        email: 'test@example.com',
      );

      when(mockRemote.forgetPassword(any)).thenThrow(Exception('server error'));

      final result = await repo.forgetPassword(requestEntity);

      expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
    });
  });

  group('verifyResetCode', () {
    test('returns success when remote call succeeds', () async {
      const requestEntity = VerifyResetCodeRequestEntity(resetCode: '123456');
      final responseDto = VerifyResetCodeResponseDto(
        status: 'Code verified successfully',
      );

      when(
        mockRemote.verifyResetCode(any),
      ).thenAnswer((_) async => responseDto);

      final result = await repo.verifyResetCode(requestEntity);

      expect(result, isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>());
      verify(mockRemote.verifyResetCode(any)).called(1);
    });

    test('returns error when remote throws', () async {
      const requestEntity = VerifyResetCodeRequestEntity(resetCode: '123456');

      when(
        mockRemote.verifyResetCode(any),
      ).thenThrow(Exception('invalid code'));

      final result = await repo.verifyResetCode(requestEntity);

      expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
    });
  });

  group('resetPassword', () {
    test('returns success when remote call succeeds', () async {
      const requestEntity = ResetPasswordRequestEntity(
        email: 'test@example.com',
        newPassword: 'newPassword123',
      );

      final responseDto = ResetPasswordResponseDto(
        message: 'Password reset successfully',
        token: 'token_123',
      );

      when(mockRemote.resetPassword(any)).thenAnswer((_) async => responseDto);

      final result = await repo.resetPassword(requestEntity);

      expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
      verify(mockRemote.resetPassword(any)).called(1);
    });

    test('returns error when remote throws', () async {
      const requestEntity = ResetPasswordRequestEntity(
        email: 'test@example.com',
        newPassword: 'newPassword123',
      );

      when(mockRemote.resetPassword(any)).thenThrow(Exception('network fail'));

      final result = await repo.resetPassword(requestEntity);

      expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
    });
  });
}
