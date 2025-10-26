import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/data_sources/remote/register_remote_ds.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_response_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/user_dto.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/repositories_impl/register_repo_impl.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/register_response_entity.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/user_dto_entity.dart';

import 'register_repo_impl_test.mocks.dart';

@GenerateMocks([RegisterRemoteDataSource])
void main() {
  late MockRegisterRemoteDataSource mockRegisterRemoteDataSource;
  late RegisterRepositoryImpl registerRepositoryImpl;
  late RegisterRequestModel registerRequestModel;
  late RegisterResponseModel registerResponseModel;
  late RegisterResponseEntity registerResponseEntity;
  late UserDtoEntity userDtoEntity;
  late UserDto userDto;

  setUp(() {
    userDtoEntity = UserDtoEntity(
      id: "id",
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
    );
    userDto = UserDto(
      id: "id",
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
    );
    registerResponseEntity = RegisterResponseEntity(
      token: "token",
      message: "message",
      userDtoEntity: userDtoEntity,
    );
    registerRequestModel = RegisterRequestModel(
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
      password: "password",
    );
    registerResponseModel = RegisterResponseModel(
      message: "message",
      token: "token",
      userDto: userDto,
    );
    mockRegisterRemoteDataSource = MockRegisterRemoteDataSource();
    registerRepositoryImpl = RegisterRepositoryImpl(
      registerRemoteDataSource: mockRegisterRemoteDataSource,
    );
  });

  test("Success case for register() with ApiSuccessResult", () async {
    //Arrange
    when(
      mockRegisterRemoteDataSource.register(registerRequestModel),
    ).thenAnswer((_) async => registerResponseModel);
    //Act
    var result = await registerRepositoryImpl.register(registerRequestModel);
    //Assert
    expect(result, isA<ApiResult<RegisterResponseEntity>>());
    var successResult = result as ApiSuccessResult<RegisterResponseEntity>;
    expect(successResult.data, isA<RegisterResponseEntity>());
    expect(successResult.data.token, equals(registerResponseEntity.token));
    expect(successResult.data.message, equals(registerResponseEntity.message));
  });

  test("Error case for register() with DioException", () async {
    //Arrange
    final dioException = DioException(requestOptions: RequestOptions());
    when(
      mockRegisterRemoteDataSource.register(registerRequestModel),
    ).thenThrow(dioException);
    //Act
    var result = await registerRepositoryImpl.register(registerRequestModel);
    //Assert
    expect(result, isA<ApiResult<RegisterResponseEntity>>());
    var errorResult = result as ApiErrorResult<RegisterResponseEntity>;
    expect(errorResult.failure, isA<ServerFailure>());
    expect(errorResult.failure, isNotNull);
    expect(errorResult.failure.errorMessage, isNotEmpty);

    verify(
      mockRegisterRemoteDataSource.register(registerRequestModel),
    ).called(1);
  });

  test("Error case for register() with generic DioException", () async {
    //Arrange
    const errorMessage = "error";
    final failure = Failure(errorMessage: errorMessage);
    when(
      mockRegisterRemoteDataSource.register(registerRequestModel),
    ).thenThrow(failure);
    //Act
    var result = await registerRepositoryImpl.register(registerRequestModel);
    //Assert
    expect(result, isA<ApiResult<RegisterResponseEntity>>());
    var errorResult = result as ApiErrorResult<RegisterResponseEntity>;
    expect(errorResult.failure, isA<Failure>());
    expect(errorResult.failure, isNotNull);
    expect(errorResult.failure.errorMessage, isNotEmpty);

    verify(
      mockRegisterRemoteDataSource.register(registerRequestModel),
    ).called(1);
  });
}
