import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/forget_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/reset_password_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/request/verify_reset_code_request_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/forget_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/reset_password_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/models/response/verify_reset_code_response_dto.dart';
import 'package:super_fitness_app/features/auth/forget_password/data_sources/sources/remote/forget_password_remote_ds.dart';

@GenerateMocks([ForgetPasswordRemoteDs])
import 'forget_password_remote_ds_test.mocks.dart';

void main() {
  late MockForgetPasswordRemoteDs mockRemoteDs;

  setUp(() {
    mockRemoteDs = MockForgetPasswordRemoteDs();
  });

  group('ForgetPasswordRemoteDs', () {
    test(
      'should call forgetPassword and return ForgetPasswordResponseDto',
      () async {
        final request = ForgetPasswordRequestDto(email: 'user@example.com');
        final response = ForgetPasswordResponseDto(
          message: 'Reset link sent successfully',
          info: 'Please check your email',
        );

        when(
          mockRemoteDs.forgetPassword(request),
        ).thenAnswer((_) async => response);

        final result = await mockRemoteDs.forgetPassword(request);

        expect(result, isA<ForgetPasswordResponseDto>());
        expect(result.message, 'Reset link sent successfully');
        expect(result.info, 'Please check your email');
        verify(mockRemoteDs.forgetPassword(request)).called(1);
        verifyNoMoreInteractions(mockRemoteDs);
      },
    );

    test(
      'should call verifyResetCode and return VerifyResetCodeResponseDto',
      () async {
        final request = VerifyResetCodeRequestDto(resetCode: '123456');
        final response = VerifyResetCodeResponseDto(
          status: 'Code verified successfully',
        );

        when(
          mockRemoteDs.verifyResetCode(request),
        ).thenAnswer((_) async => response);

        final result = await mockRemoteDs.verifyResetCode(request);

        expect(result, isA<VerifyResetCodeResponseDto>());
        expect(result.status, 'Code verified successfully');
        verify(mockRemoteDs.verifyResetCode(request)).called(1);
        verifyNoMoreInteractions(mockRemoteDs);
      },
    );

    test(
      'should call resetPassword and return ResetPasswordResponseDto',
      () async {
        final request = ResetPasswordRequestDto(
          email: 'user@example.com',
          newPassword: 'newPassword123',
        );

        final response = ResetPasswordResponseDto(
          message: 'Password reset successfully',
          token: 'xyz123token',
        );

        when(
          mockRemoteDs.resetPassword(request),
        ).thenAnswer((_) async => response);

        final result = await mockRemoteDs.resetPassword(request);

        expect(result, isA<ResetPasswordResponseDto>());
        expect(result.message, 'Password reset successfully');
        expect(result.token, 'xyz123token');
        verify(mockRemoteDs.resetPassword(request)).called(1);
        verifyNoMoreInteractions(mockRemoteDs);
      },
    );
  });
}
