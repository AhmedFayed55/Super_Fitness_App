import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/logout/domain/entities/logout_entity.dart';
import 'package:super_fitness_app/features/auth/logout/domain/repo/logout_repo.dart';
import 'package:super_fitness_app/features/auth/logout/domain/use_case/logout_use_case.dart';

import 'logout_use_case_test.mocks.dart';

@GenerateMocks([LogoutRepo])
void main() {
  late MockLogoutRepo mockLogoutRepo;
  late LogoutUseCase logoutUseCase;
  provideDummy<ApiResult<LogoutEntity>>(
    ApiSuccessResult<LogoutEntity>(data: LogoutEntity(message: 'dummy')),
  );

  setUp(() {
    mockLogoutRepo = MockLogoutRepo();
    logoutUseCase = LogoutUseCase(mockLogoutRepo);
  });

  group('LogoutUseCase', () {
    test('should return ApiSuccessResult when logout is successful', () async {
      // Arrange
      final logoutEntity = LogoutEntity(message: 'Logout success');
      final successResult = ApiSuccessResult<LogoutEntity>(data: logoutEntity);

      when(mockLogoutRepo.logoutRepo()).thenAnswer((_) async => successResult);

      // Act
      final result = await logoutUseCase.call();

      // Assert
      expect(result, isA<ApiSuccessResult<LogoutEntity>>());
      expect(
        (result as ApiSuccessResult<LogoutEntity>).data.message,
        'Logout success',
      );
      verify(mockLogoutRepo.logoutRepo()).called(1);
    });

    test('should return ApiErrorResult when logout fails', () async {
      // Arrange
      final errorResult = ApiErrorResult<LogoutEntity>(
        failure: Failure(errorMessage: 'Server error'),
      );

      when(mockLogoutRepo.logoutRepo()).thenAnswer((_) async => errorResult);

      // Act
      final result = await logoutUseCase.call();

      // Assert
      expect(result, isA<ApiErrorResult<LogoutEntity>>());
      expect(
        (result as ApiErrorResult<LogoutEntity>).failure.errorMessage,
        'Server error',
      );
      verify(mockLogoutRepo.logoutRepo()).called(1);
      verifyNoMoreInteractions(mockLogoutRepo);
    });
  });
}
