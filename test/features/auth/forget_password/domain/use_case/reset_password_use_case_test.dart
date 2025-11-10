import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/use_case/reset_password_use_case.dart';
import 'forget_password_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepository])
void main() {
  late MockForgetPasswordRepository mockRepo;
  late ResetPasswordUseCase useCase;

  setUp(() {
    mockRepo = MockForgetPasswordRepository();
    useCase = ResetPasswordUseCase(mockRepo);
  });

  test('should call repo.resetPassword() and return success', () async {
    const request = ResetPasswordRequestEntity(
      email: 'test@example.com',
      newPassword: 'newPassword123',
    );
    const response = ResetPasswordResponseEntity(
      message: 'Password reset successful',
      token: 'new_token_123',
    );

    provideDummy<ApiResult<ResetPasswordResponseEntity>>(
      ApiSuccessResult(data: response),
    );

    when(
      mockRepo.resetPassword(any),
    ).thenAnswer((_) async => ApiSuccessResult(data: response));

    final result = await useCase.invoke(request);

    verify(mockRepo.resetPassword(any)).called(1);
    expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());

    final success = result as ApiSuccessResult<ResetPasswordResponseEntity>;
    expect(success.data.message, equals('Password reset successful'));
    expect(success.data.token, equals('new_token_123'));
  });

  test('should return failure when repo.resetPassword() fails', () async {
    const request = ResetPasswordRequestEntity(
      email: 'test@example.com',
      newPassword: 'newPassword123',
    );

    provideDummy<ApiResult<ResetPasswordResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'Server error')),
    );

    when(mockRepo.resetPassword(any)).thenAnswer(
      (_) async =>
          ApiErrorResult(failure: Failure(errorMessage: 'Server error')),
    );

    final result = await useCase.invoke(request);

    verify(mockRepo.resetPassword(any)).called(1);
    expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());

    final failure = result as ApiErrorResult<ResetPasswordResponseEntity>;
    expect(failure.failure.errorMessage, equals('Server error'));
  });
}
