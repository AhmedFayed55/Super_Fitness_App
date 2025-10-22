import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/forget_password_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/forget_password_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/use_case/forget_password_use_case.dart';

import 'forget_password_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepository])
void main() {
  late MockForgetPasswordRepository mockRepo;
  late ForgetPasswordUseCase useCase;

  setUp(() {
    mockRepo = MockForgetPasswordRepository();
    useCase = ForgetPasswordUseCase(mockRepo);
  });

  test('should call repo.forgetPassword() and return success', () async {
    const request = ForgetPasswordRequestEntity(email: 'test@example.com');
    const response = ForgetPasswordResponseEntity(
      message: 'Reset link sent',
      info: 'Please check your email',
    );

    provideDummy<ApiResult<ForgetPasswordResponseEntity>>(
      ApiSuccessResult(data: response),
    );

    when(
      mockRepo.forgetPassword(any),
    ).thenAnswer((_) async => ApiSuccessResult(data: response));

    final result = await useCase.invoke(request);

    verify(mockRepo.forgetPassword(any)).called(1);
    expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());

    final success = result as ApiSuccessResult<ForgetPasswordResponseEntity>;
    expect(success.data.message, equals('Reset link sent'));
  });

  test('should return failure when repo.forgetPassword() fails', () async {
    const request = ForgetPasswordRequestEntity(email: 'test@example.com');

    provideDummy<ApiResult<ForgetPasswordResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'Network error')),
    );

    when(mockRepo.forgetPassword(any)).thenAnswer(
      (_) async =>
          ApiErrorResult(failure: Failure(errorMessage: 'Network error')),
    );

    final result = await useCase.invoke(request);

    verify(mockRepo.forgetPassword(any)).called(1);
    expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());

    final failure = result as ApiErrorResult<ForgetPasswordResponseEntity>;
    expect(failure.failure.errorMessage, equals('Network error'));
  });
}
