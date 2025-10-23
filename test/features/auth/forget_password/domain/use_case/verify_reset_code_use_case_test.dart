import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/request/verify_reset_code_request_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/entities/response/verify_reset_code_response_entity.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/repositories/forget_password_repo.dart';
import 'package:super_fitness_app/features/auth/forget_password/domain/use_case/verify_reset_code_use_case.dart';
import 'verify_reset_code_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepository])
void main() {
  late MockForgetPasswordRepository mockRepo;
  late VerifyResetCodeUseCase useCase;

  setUp(() {
    mockRepo = MockForgetPasswordRepository();
    useCase = VerifyResetCodeUseCase(mockRepo);
  });

  test('should call repo.verifyResetCode() and return success', () async {
    const request = VerifyResetCodeRequestEntity(resetCode: '123456');
    const response = VerifyResetCodeResponseEntity(status: 'Code verified');

    provideDummy<ApiResult<VerifyResetCodeResponseEntity>>(
      ApiSuccessResult(data: response),
    );

    when(
      mockRepo.verifyResetCode(any),
    ).thenAnswer((_) async => ApiSuccessResult(data: response));

    final result = await useCase.invoke(request);

    verify(mockRepo.verifyResetCode(any)).called(1);
    expect(result, isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>());

    final success = result as ApiSuccessResult<VerifyResetCodeResponseEntity>;
    expect(success.data.status, equals('Code verified'));
  });

  test('should return failure when repo.verifyResetCode() fails', () async {
    const request = VerifyResetCodeRequestEntity(resetCode: '123456');

    provideDummy<ApiResult<VerifyResetCodeResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'Invalid code')),
    );

    when(mockRepo.verifyResetCode(any)).thenAnswer(
      (_) async =>
          ApiErrorResult(failure: Failure(errorMessage: 'Invalid code')),
    );

    final result = await useCase.invoke(request);

    verify(mockRepo.verifyResetCode(any)).called(1);
    expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());

    final failure = result as ApiErrorResult<VerifyResetCodeResponseEntity>;
    expect(failure.failure.errorMessage, equals('Invalid code'));
  });
}
