import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/request/login_request_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/entities/response/user_response_entity.dart';
import 'package:super_fitness_app/features/auth/login/domain/repositories/login_screen_repo.dart';
import 'package:super_fitness_app/features/auth/login/domain/use_cases/login_use_case.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([LoginScreenRepo])
void main() {
  late LoginScreenRepo mockLoginScreenRepo;
  late LoginUseCase useCase;
  late LoginRequestEntity requestEntity;
  late UserResponseEntity responseEntity;

  setUpAll(() {
    mockLoginScreenRepo = MockLoginScreenRepo();
    useCase = LoginUseCase(mockLoginScreenRepo);
    requestEntity = const LoginRequestEntity(
      email: "john@elevate.com",
      password: "john",
    );
    responseEntity = const UserResponseEntity(id: "15135", firstName: "John");
  });

  group("Login UseCase Test", () {
    test(
      "Success case should return ApiSuccessResult<UserResponseEntity>",
      () async {
        provideDummy<ApiResult<UserResponseEntity>>(
          ApiSuccessResult(data: responseEntity),
        );

        when(
          mockLoginScreenRepo.login(requestEntity),
        ).thenAnswer((_) async => ApiSuccessResult(data: responseEntity));

        var result = await useCase.invoke(requestEntity);

        verify(mockLoginScreenRepo.login(requestEntity)).called(1);

        expect(result, isA<ApiSuccessResult<UserResponseEntity>>());
        result as ApiSuccessResult<UserResponseEntity>;
        expect(result.data, isA<UserResponseEntity>());
        expect(result.data, isNotNull);
        expect(result.data, equals(responseEntity));
        expect(result.data.id, equals(responseEntity.id));
      },
    );

    test(
      "Error case should return ApiErrorResult<UserResponseEntity>",
      () async {
        var errorResult = ApiErrorResult<UserResponseEntity>(
          failure: Failure(errorMessage: "Unhandled Error", code: "404"),
        );

        provideDummy<ApiResult<UserResponseEntity>>(errorResult);

        when(
          mockLoginScreenRepo.login(requestEntity),
        ).thenAnswer((_) async => errorResult);

        var result = await useCase.invoke(requestEntity);

        verify(mockLoginScreenRepo.login(requestEntity)).called(1);

        expect(result, isA<ApiErrorResult<UserResponseEntity>>());
        result as ApiErrorResult<UserResponseEntity>;
        expect(result.failure, isA<Failure>());
        expect(result.failure, isNotNull);
        expect(result.failure.errorMessage, isNotNull);
        expect(result.failure.errorMessage, errorResult.failure.errorMessage);
        expect(result.failure.code, equals(errorResult.failure.code));
      },
    );
  });
}
