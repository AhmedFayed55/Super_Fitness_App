import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/core/services/token_service.dart';
import 'package:super_fitness_app/features/auth/login/data/data_sources/login_screen_ds.dart';
import 'package:super_fitness_app/features/auth/login/data/models/request/login_request_dto.dart';
import 'package:super_fitness_app/features/auth/login/data/models/response/login_response_dto.dart';
import 'package:super_fitness_app/features/auth/login/data/models/response/user_response_dto.dart';
import 'package:super_fitness_app/features/auth/login/data/repositories/login_screen_repo_impl.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/response/user_response_entity.dart';

import 'login_screen_repo_impl_test.mocks.dart';

@GenerateMocks([LoginScreenDataSource, TokenService])
void main() {
  late LoginScreenDataSource mockDataSource;
  late TokenService mockTokenService;
  late LoginScreenRepoImpl repoImpl;
  late LoginRequestEntity requestEntity;
  late LoginRequestDto requestDto;
  late UserResponseDto responseEntity;
  late LoginResponseDto responseDto;

  setUpAll(() {
    mockDataSource = MockLoginScreenDataSource();
    mockTokenService = MockTokenService();
    repoImpl = LoginScreenRepoImpl(mockDataSource, mockTokenService);
    requestEntity = const LoginRequestEntity(
      email: "john@elevate.com",
      password: "john",
    );
    requestDto = const LoginRequestDto(
      email: "john@elevate.com",
      password: "john",
    );
    responseEntity = const UserResponseDto(id: "15135", firstName: "John");
    responseDto = const LoginResponseDto(
      message: "success",
      user: UserResponseDto(id: "15135"),
      token: "4542asfda",
    );
  });

  group('LoginScreenRepoImpl test', () {
    test(
      "when call login should return ApiSuccessResult<UserResponseEntity>",
      () async {
        when(
          mockDataSource.login(requestDto),
        ).thenAnswer((_) async => responseDto);

        var result = await repoImpl.login(requestEntity);

        verify(mockDataSource.login(requestDto)).called(1);
        verify(mockTokenService.saveToken(responseDto.token!)).called(1);

        expect(result, isA<ApiSuccessResult<UserResponseEntity>>());
        result as ApiSuccessResult<UserResponseEntity>;
        expect(result.data.id, responseEntity.id);
      },
    );

    test(
      "Error case when DioException should return ApiErrorResult<UserResponseEntity>",
      () async {
        final DioException dioException = DioException(
          requestOptions: RequestOptions(path: ""),
        );

        when(mockDataSource.login(requestDto)).thenThrow(dioException);

        var result = await repoImpl.login(requestEntity);

        verify(mockDataSource.login(requestDto)).called(1);
        verifyNever(mockTokenService.saveToken(responseDto.token!));

        expect(result, isA<ApiErrorResult<UserResponseEntity>>());
        result as ApiErrorResult<UserResponseEntity>;
        expect(result.failure, isA<ServerFailure>());
        expect(result.failure, isNotNull);
        expect(result.failure.errorMessage, isNotEmpty);
      },
    );

    test(
      "Error case when unhandled exception should return ApiErrorResult<UserResponseEntity>",
      () async {
        final Exception exception = Exception("Error");

        when(mockDataSource.login(requestDto)).thenThrow(exception);

        var result = await repoImpl.login(requestEntity);

        verify(mockDataSource.login(requestDto)).called(1);
        verifyNever(mockTokenService.saveToken(responseDto.token!));

        expect(result, isA<ApiErrorResult<UserResponseEntity>>());
        result as ApiErrorResult<UserResponseEntity>;
        expect(result.failure, isA<Failure>());
        expect(result.failure, isNotNull);
        expect(result.failure.errorMessage, isNotEmpty);
        expect(result.failure.errorMessage, contains("Error"));
      },
    );
  });
}
