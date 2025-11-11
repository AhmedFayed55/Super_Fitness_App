import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/services/token_service.dart';
import 'package:super_fitness_app/features/auth/logout/data/data_source/logout_ds.dart';
import 'package:super_fitness_app/features/auth/logout/data/model/logout_response_dto.dart';
import 'package:super_fitness_app/features/auth/logout/data/repo_imp/logout_repo_imp.dart';
import 'package:super_fitness_app/features/auth/logout/domain/entities/logout_entity.dart';

import 'logout_repo_imp_test.mocks.dart';

@GenerateMocks([LogoutDataSource, TokenService])
void main() {
  late MockLogoutDataSource mockLogoutDataSource;
  late MockTokenService mockTokenService;
  late LogoutRepoImp repo;

  setUp(() {
    mockLogoutDataSource = MockLogoutDataSource();
    mockTokenService = MockTokenService();
    repo = LogoutRepoImp(mockLogoutDataSource, mockTokenService);
  });

  group('LogoutRepoImp', () {
    test(
      'should return ApiResult.success with LogoutEntity and delete token',
      () async {
        // Arrange
        final dto = LogoutResponseDto(message: "Logout success");
        when(
          mockLogoutDataSource.logoutDataSource(),
        ).thenAnswer((_) async => dto);
        when(mockTokenService.deleteToken()).thenAnswer((_) async {});

        // Act
        final result = await repo.logoutRepo();

        // Assert
        expect(result, isA<ApiResult<LogoutEntity>>());

        verify(mockLogoutDataSource.logoutDataSource()).called(1);
        verify(mockTokenService.deleteToken()).called(1);
        verifyNoMoreInteractions(mockLogoutDataSource);
        verifyNoMoreInteractions(mockTokenService);
      },
    );

    test(
      'should return ApiResult.failure when data source throws exception',
      () async {
        // Arrange
        when(
          mockLogoutDataSource.logoutDataSource(),
        ).thenThrow(Exception('Network Error'));

        // Act
        final result = await repo.logoutRepo();

        // Assert
        expect(result, isA<ApiResult<LogoutEntity>>());
        verify(mockLogoutDataSource.logoutDataSource()).called(1);
        verifyNever(mockTokenService.deleteToken());
      },
    );
  });
}
