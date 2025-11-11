import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/edit-profile/domain/entities/user.dart';
import 'package:super_fitness_app/features/edit-profile/domain/repo/edit_profile_repo.dart';
import 'package:super_fitness_app/features/edit-profile/domain/usecase/edit_profile_usecase.dart';

import 'edit_profile_usecase_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late MockEditProfileRepo mockRepo;
  late EditProfileUsecase usecase;

  final user = UserEntity(
    id: '1',
    firstName: 'Ahmed',
    lastName: 'Yehia',
    email: 'test@test.com',
    gender: 'male',
    age: 22,
    weight: 75,
    height: 180,
    activityLevel: 'Intermediate',
    goal: 'Gain weight',
    photo: 'photo',
    createdAt: DateTime.now(),
  );

  setUp(() {
    mockRepo = MockEditProfileRepo();
    usecase = EditProfileUsecase(mockRepo);

    provideDummy<ApiResult<dynamic>>(ApiSuccessResult(data: null));
  });

  test('should return success result when repo returns success', () async {
    // Arrange
    when(
      mockRepo.editUser(user),
    ).thenAnswer((_) async => ApiSuccessResult(data: "Success"));

    // Act
    final result = await usecase.invoke(user);

    // Assert
    expect(result, isA<ApiSuccessResult>());
    verify(mockRepo.editUser(user)).called(1);
  });

  test('should return error result when repo returns error', () async {
    // Arrange
    when(mockRepo.editUser(user)).thenAnswer(
      (_) async => ApiErrorResult(failure: Failure(errorMessage: "error")),
    );

    // Act
    final result = await usecase.invoke(user);

    // Assert
    expect(result, isA<ApiErrorResult>());
    verify(mockRepo.editUser(user)).called(1);
  });
}
