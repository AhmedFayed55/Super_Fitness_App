import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/profile/domain/entities/logged_user_data/user_data_response_entity.dart';
import 'package:super_fitness_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:super_fitness_app/features/home_screen/domain/use_cases/get_profile_usecase.dart';

import '../../../profile/domain/use_cases/get_help_screen_content_use_case_test.mocks.dart';


@GenerateMocks([ProfileRepo])
void main() {
  late ProfileRepo repo;
  late GetUserProfileUseCase useCase;
  late UserDataResponseEntity userData;

  setUp(() {
    repo = MockProfileRepo();
    useCase = GetUserProfileUseCase(repo);

    userData = UserDataResponseEntity(
      id: "123",
      firstName: "Mohamed",
      lastName: "Ali",
      email: "mohamed@example.com",
      photo: "photo_url",
      age: 1,
      height: 1,
      weight: 1,
      createdAt: "createdAt",
      activityLevel: "activityLevel",
      gender: "gender",
      goal: "goal",
    );
  });

  test("success case for GetUserProfileUseCase", () async {
    final mockResult = ApiSuccessResult<UserDataResponseEntity>(data: userData);
    provideDummy<ApiResult<UserDataResponseEntity>>(mockResult);
    when(repo.getUserData()).thenAnswer((_) async => mockResult);

    final result = await useCase.call();

    verify(repo.getUserData()).called(1);

    expect(result, isA<ApiSuccessResult<UserDataResponseEntity>>());
    final successResult = result as ApiSuccessResult<UserDataResponseEntity>;
    expect(successResult.data, equals(userData));
    expect(successResult.data.firstName, equals("Mohamed"));
  });

  test("error case for GetUserProfileUseCase", () async {
    final mockError = ApiErrorResult<UserDataResponseEntity>(
      failure: Failure(errorMessage: "error occurred"),
    );

    provideDummy<ApiResult<UserDataResponseEntity>>(mockError);
    when(repo.getUserData()).thenAnswer((_) async => mockError);

    final result = await useCase.call();

    verify(repo.getUserData()).called(1);

    expect(result, isA<ApiErrorResult<UserDataResponseEntity>>());
    final errorResult = result as ApiErrorResult<UserDataResponseEntity>;
    expect(errorResult.failure.errorMessage, equals("error occurred"));
  });
}
