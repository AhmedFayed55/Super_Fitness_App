import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/response/get_user_data_response_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/entities/user_entity.dart';
import 'package:super_fitness_app/features/smart_coach/domain/repositories/smart_coach_repo.dart';
import 'package:super_fitness_app/features/smart_coach/domain/use_case/get_user_data_use_case.dart';
import 'get_user_data_use_case_test.mocks.dart';

@GenerateMocks([SmartCoachRepository])
void main() {
  late MockSmartCoachRepository mockRepo;
  late GetUserDataUseCase useCase;

  setUp(() {
    mockRepo = MockSmartCoachRepository();
    useCase = GetUserDataUseCase(mockRepo);
  });

  test('should call repo.getUserData and return success', () async {
    const entity = GetUserDataResponseEntity(
      message: 'ok',
      user: UserEntity(
        id: '1',
        firstName: 'Ahmed',
        lastName: 'Rageh',
        email: 'ahmed@example.com',
        gender: 'male',
        age: 25,
        weight: 75,
        height: 180,
        activityLevel: 'level2',
        goal: 'Build muscle',
        photo: 'profile.png',
        createdAt: '2025-11-09',
      ),
    );
    provideDummy<ApiResult<GetUserDataResponseEntity>>(
      ApiSuccessResult(data: entity),
    );
    when(
      mockRepo.getUserData(),
    ).thenAnswer((_) async => ApiSuccessResult(data: entity));

    final result = await useCase.call();

    verify(mockRepo.getUserData()).called(1);
    expect(result, isA<ApiSuccessResult<GetUserDataResponseEntity>>());
  });

  test('should return error when repo fails', () async {
    provideDummy<ApiResult<GetUserDataResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'error')),
    );
    when(mockRepo.getUserData()).thenAnswer(
      (_) async => ApiErrorResult(failure: Failure(errorMessage: 'error')),
    );

    final result = await useCase.call();

    expect(result, isA<ApiErrorResult<GetUserDataResponseEntity>>());
  });
}
