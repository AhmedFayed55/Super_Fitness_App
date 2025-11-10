import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/change_password/data/data_sources/remote/change_pass_remote_ds.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_pass_response.dart';
import 'package:super_fitness_app/features/auth/change_password/data/models/change_password_request.dart';
import 'package:super_fitness_app/features/auth/change_password/data/repositories_impl/change_pass_repo_impl.dart';
import 'package:super_fitness_app/features/auth/change_password/domain/entities/change_pass_entity.dart';
import 'change_pass_repo_impl_test.mocks.dart';

@GenerateMocks([ChangePasswordRemoteDataSource])
void main() {
  late MockChangePasswordRemoteDataSource mockDataSource;
  late ChangePasswordRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockChangePasswordRemoteDataSource();
    repository = ChangePasswordRepositoryImpl(mockDataSource);
  });

  group("Test ChangePasswordRepositoryImpl in Domain_Layer", () {
    test("success case with ApiSuccessResult", () async {
      /// Arrange
      final response = ChangePasswordResponse(
        message: 'message',
        token: 'token',
      );
      final entity = ChangePasswordEntity(message: 'message', token: 'token');
      final request = ChangePasswordRequest(
        password: 'password',
        newPassword: 'newPassword',
      );
      when(
        mockDataSource.changePassword(request),
      ).thenAnswer((_) async => response);

      /// Act
      final result = await repository.changePassword(request);

      /// Assert
      expect(result, isA<ApiResult<ChangePasswordEntity>>());
      final success = result as ApiSuccessResult<ChangePasswordEntity>;
      expect(success.data.message, equals(entity.message));
      expect(success.data.token, equals(entity.token));

      verify(mockDataSource.changePassword(request)).called(1);
    });

    test("Error case with ApiErrorResult", () async {
      /// Arrange
      final request = ChangePasswordRequest(
        password: "password",
        newPassword: "newPassword",
      );
      when(
        mockDataSource.changePassword(request),
      ).thenThrow(DioException(requestOptions: RequestOptions()));

      /// Act
      final result = await repository.changePassword(request);

      /// Assert
      expect(result, isA<ApiErrorResult<ChangePasswordEntity>>());
      final error = result as ApiErrorResult<ChangePasswordEntity>;
      expect(error.failure, isA<ServerFailure>());

      verify(mockDataSource.changePassword(request)).called(1);
    });
  });
}
