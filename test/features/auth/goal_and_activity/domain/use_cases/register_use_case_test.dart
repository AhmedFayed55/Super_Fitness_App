import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/data/models/register_request_model.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/register_response_entity.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/entities/user_dto_entity.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/repositories/register_repo.dart';
import 'package:super_fitness_app/features/auth/goal_and_activity/domain/use_cases/register_use_case.dart';

import 'register_use_case_test.mocks.dart';

@GenerateMocks([RegisterRepository])
void main() {
  late MockRegisterRepository mockRegisterRepository;
  late RegisterResponseEntity registerResponseEntity;
  late RegisterUseCase registerUseCase;
  late RegisterRequestModel registerRequestModel;

  setUp(() {
    mockRegisterRepository = MockRegisterRepository();
    registerUseCase = RegisterUseCase(
      registerRepository: mockRegisterRepository,
    );
  });

  test(
    "register() Should return ApiSuccessResult<RegisterResponseEntity> when Success",
    () async {
      // Arrange
      registerResponseEntity = RegisterResponseEntity(
        message: "message",
        token: "token",
        userDtoEntity: UserDtoEntity(
          id: "id",
          firstName: "firstName",
          lastName: "lastName",
          email: "email",
        ),
      );
      registerRequestModel = RegisterRequestModel(
        firstName: "firstName",
        lastName: "lastName",
        email: "email",
        password: "password",
        rePassword: "rePassword",
      );
      var mockSuccessResult = ApiSuccessResult<RegisterResponseEntity>(
        data: registerResponseEntity,
      );
      provideDummy<ApiResult<RegisterResponseEntity>>(mockSuccessResult);
      when(
        mockRegisterRepository.register(registerRequestModel),
      ).thenAnswer((_) async => mockSuccessResult);

      // Act
      var result = await registerUseCase.register(registerRequestModel);

      // Assert
      expect(result, isA<ApiResult<RegisterResponseEntity>>());
    },
  );
}
