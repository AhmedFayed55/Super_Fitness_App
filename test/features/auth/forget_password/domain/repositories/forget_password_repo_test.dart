import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/forget_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/verify_reset_code_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/forget_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/verify_reset_code_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';
import 'forget_password_repo_test.mocks.dart';

void _registerDummyValues() {
  provideDummy<ApiResult<ForgetPasswordResponseEntity>>(
    ApiSuccessResult(
      data: const ForgetPasswordResponseEntity(message: '', info: ''),
    ),
  );
  provideDummy<ApiResult<VerifyResetCodeResponseEntity>>(
    ApiSuccessResult(data: const VerifyResetCodeResponseEntity(status: '')),
  );
  provideDummy<ApiResult<ResetPasswordResponseEntity>>(
    ApiSuccessResult(
      data: const ResetPasswordResponseEntity(message: '', token: ''),
    ),
  );
}

@GenerateMocks([ForgetPasswordRepository])
void main() {
  late MockForgetPasswordRepository mockRepo;

  setUpAll(() {
    _registerDummyValues();
  });

  setUp(() {
    mockRepo = MockForgetPasswordRepository();
  });

  group('ForgetPasswordRepository contract tests', () {
    test(
      'forgetPassword should return ApiResult<ForgetPasswordResponseEntity>',
      () async {
        const request = ForgetPasswordRequestEntity(email: 'user@example.com');
        const response = ForgetPasswordResponseEntity(
          message: 'Success',
          info: 'Reset code sent',
        );

        when(
          mockRepo.forgetPassword(request),
        ).thenAnswer((_) async => ApiSuccessResult(data: response));

        final result = await mockRepo.forgetPassword(request);

        expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
        verify(mockRepo.forgetPassword(request)).called(1);
      },
    );

    test(
      'verifyResetCode should return ApiResult<VerifyResetCodeResponseEntity>',
      () async {
        const request = VerifyResetCodeRequestEntity(resetCode: '123456');
        const response = VerifyResetCodeResponseEntity(status: 'Success');

        when(
          mockRepo.verifyResetCode(request),
        ).thenAnswer((_) async => ApiSuccessResult(data: response));

        final result = await mockRepo.verifyResetCode(request);

        expect(result, isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>());
        verify(mockRepo.verifyResetCode(request)).called(1);
      },
    );

    test(
      'resetPassword should return ApiResult<ResetPasswordResponseEntity>',
      () async {
        const request = ResetPasswordRequestEntity(
          email: 'user@example.com',
          newPassword: 'newPass123',
        );
        const response = ResetPasswordResponseEntity(
          message: 'Password reset done',
          token: 'token123',
        );

        when(
          mockRepo.resetPassword(request),
        ).thenAnswer((_) async => ApiSuccessResult(data: response));

        final result = await mockRepo.resetPassword(request);

        expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
        verify(mockRepo.resetPassword(request)).called(1);
      },
    );
  });
}
