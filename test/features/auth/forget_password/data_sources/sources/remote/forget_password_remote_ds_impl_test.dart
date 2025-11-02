import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_services.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/forget_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/reset_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/verify_reset_code_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/forget_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/reset_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/verify_reset_code_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/sources/remote/forget_password_remote_ds_impl.dart';

import 'forget_password_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late ForgetPasswordRemoteDsImpl dataSource;

  setUp(() {
    mockApiServices = MockApiServices();
    dataSource = ForgetPasswordRemoteDsImpl(apiService: mockApiServices);
  });

  group('ForgetPasswordRemoteDsImpl', () {
    group('forgetPassword', () {
      test('returns ForgetPasswordResponseDto on success', () async {
        // Arrange
        final request = ForgetPasswordRequestDto(email: 'user@example.com');
        final response = ForgetPasswordResponseDto(
          message: 'Reset link sent successfully',
          info: 'Please check your email',
        );

        when(
          mockApiServices.forgotPassword(any),
        ).thenAnswer((_) async => response);

        // Act
        final result = await dataSource.forgetPassword(request);

        // Assert
        expect(result, isA<ForgetPasswordResponseDto>());
        expect(result.message, 'Reset link sent successfully');
        expect(result.info, 'Please check your email');
        verify(mockApiServices.forgotPassword(request)).called(1);
      });

      test('throws DioException when API fails', () async {
        final request = ForgetPasswordRequestDto(email: 'user@example.com');

        when(mockApiServices.forgotPassword(any)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/forget-password'),
          ),
        );

        expect(
          () => dataSource.forgetPassword(request),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('verifyResetCode', () {
      test('returns VerifyResetCodeResponseDto on success', () async {
        final request = VerifyResetCodeRequestDto(resetCode: '123456');
        final response = VerifyResetCodeResponseDto(
          status: 'Code verified successfully',
        );

        when(mockApiServices.verifyCode(any)).thenAnswer((_) async => response);

        final result = await dataSource.verifyResetCode(request);

        expect(result, isA<VerifyResetCodeResponseDto>());
        expect(result.status, 'Code verified successfully');
        verify(mockApiServices.verifyCode(request)).called(1);
      });

      test('throws DioException when API fails', () async {
        final request = VerifyResetCodeRequestDto(resetCode: '123456');

        when(mockApiServices.verifyCode(any)).thenThrow(
          DioException(requestOptions: RequestOptions(path: '/verify-code')),
        );

        expect(
          () => dataSource.verifyResetCode(request),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('resetPassword', () {
      test('returns ResetPasswordResponseDto on success', () async {
        final request = ResetPasswordRequestDto(
          email: 'user@example.com',
          newPassword: 'newPassword123',
        );
        final response = ResetPasswordResponseDto(
          message: 'Password reset successfully',
          token: 'abc123token',
        );

        when(
          mockApiServices.resetPassword(any),
        ).thenAnswer((_) async => response);

        final result = await dataSource.resetPassword(request);

        expect(result, isA<ResetPasswordResponseDto>());
        expect(result.message, 'Password reset successfully');
        expect(result.token, 'abc123token');
        verify(mockApiServices.resetPassword(request)).called(1);
      });

      test('throws DioException when API fails', () async {
        final request = ResetPasswordRequestDto(
          email: 'user@example.com',
          newPassword: 'newPassword123',
        );

        when(mockApiServices.resetPassword(any)).thenThrow(
          DioException(requestOptions: RequestOptions(path: '/reset-password')),
        );

        expect(
          () => dataSource.resetPassword(request),
          throwsA(isA<DioException>()),
        );
      });
    });
  });
}
