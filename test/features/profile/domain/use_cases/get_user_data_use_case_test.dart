import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_user_data_use_case.dart';

import 'get_user_data_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late ProfileRepo repo;
  late GetUserDataUseCase useCase;
  late UserDataResponseEntity userEntity;

  setUp(() {
    repo = MockProfileRepo();
    useCase = GetUserDataUseCase(repo);
    userEntity = UserDataResponseEntity(
      firstName: "john",
      lastName: "doe",
      id: "4154",
      photo: "photo@example.png",
      email: "jhon@yahoo.com",
      age: 22,
      goal: "lose weight",
      height: 180,
      weight: 75,
      activityLevel: "hard",
      createdAt: "10-10-2020",
      gender: "male",
    );
  });

  group('GetUserDataUseCase', () {
    test(
      'should return ApiSuccessResult when repo returns data successfully',
      () async {
        final mockResult = ApiSuccessResult<UserDataResponseEntity>(
          data: userEntity,
        );
        provideDummy<ApiResult<UserDataResponseEntity>>(mockResult);

        when(repo.getUserData()).thenAnswer((_) async => mockResult);

        final result = await useCase.call();

        verify(repo.getUserData()).called(1);
        expect(result, isA<ApiSuccessResult<UserDataResponseEntity>>());
        result as ApiSuccessResult<UserDataResponseEntity>;
        expect(result.data, isNotNull);
        expect(result.data.firstName, equals(userEntity.firstName));
        expect(result.data.id, equals(userEntity.id));
        expect(result.data.email, equals(userEntity.email));
      },
    );

    test('should return ApiErrorResult when repo returns failure', () async {
      final mockError = ApiErrorResult<UserDataResponseEntity>(
        failure: Failure(errorMessage: "Failed to load user data"),
      );
      provideDummy<ApiResult<UserDataResponseEntity>>(mockError);

      when(repo.getUserData()).thenAnswer((_) async => mockError);

      final result = await useCase.call();

      expect(result, isA<ApiErrorResult<UserDataResponseEntity>>());
      result as ApiErrorResult<UserDataResponseEntity>;
      expect(
        result.failure.errorMessage,
        equals(mockError.failure.errorMessage),
      );
    });
  });
}
