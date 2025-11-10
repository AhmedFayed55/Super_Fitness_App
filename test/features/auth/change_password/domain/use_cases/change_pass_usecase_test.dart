import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/entities/change_pass_entity.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/repositories/change_pass_repo.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/use_cases/change_pass_usecase.dart';

import 'change_pass_usecase_test.mocks.dart';

@GenerateMocks([ChangePasswordRepository])
void main() {
  late MockChangePasswordRepository mockRepo;
  late ChangePasswordUseCase useCase;
  late ChangePasswordRequest request;

  setUp(() {
    request = ChangePasswordRequest(
      password: "password",
      newPassword: "newPassword",
    );
    mockRepo = MockChangePasswordRepository();
    useCase = ChangePasswordUseCase(mockRepo);
  });

  group("Test ChangePasswordUseCase", () {
    test("success case with ApiSuccessResult", () async {
      // Arrange
      final entity = ChangePasswordEntity(message: "message", token: "token");
      final successResult = ApiSuccessResult<ChangePasswordEntity>(
        data: entity,
      );
      provideDummy<ApiResult<ChangePasswordEntity>>(successResult);

      when(
        mockRepo.changePassword(request),
      ).thenAnswer((_) async => successResult);

      // Act
      final result = await useCase(request);

      // Assert
      expect(result, isA<ApiResult<ChangePasswordEntity>>());
      final success = result as ApiSuccessResult<ChangePasswordEntity>;
      expect(success.data.message, equals(entity.message));
      expect(success.data.token, equals(entity.token));

      verify(mockRepo.changePassword(request)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test("error case with ApiErrorResult", () async {
      // Arrange
      final failure = Failure(errorMessage: "Server error");
      final errorResult = ApiErrorResult<ChangePasswordEntity>(
        failure: failure,
      );
      provideDummy<ApiResult<ChangePasswordEntity>>(errorResult);

      when(
        mockRepo.changePassword(request),
      ).thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase(request);

      // Assert
      expect(result, isA<ApiErrorResult<ChangePasswordEntity>>());
      final error = result as ApiErrorResult<ChangePasswordEntity>;
      expect(error.failure.errorMessage, equals("Server error"));

      verify(mockRepo.changePassword(request)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
