import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/request/get_all_exercises_request_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/response/get_all_exercises_response_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repositories/popular_training_repo.dart';
import 'popular_training_repo_test.mocks.dart';

/// Register dummy values for mockito generics
void _registerDummyValues() {
  provideDummy<ApiResult<GetAllExercisesResponseEntity>>(
    ApiSuccessResult(
      data: const GetAllExercisesResponseEntity(
        message: 'Success',
        totalExercises: 1,
        totalPages: 1,
        currentPage: 1,
        exercises: [],
      ),
    ),
  );
}

@GenerateMocks([PopularTrainingRepository])
void main() {
  late MockPopularTrainingRepository mockRepo;

  setUpAll(() {
    _registerDummyValues();
  });

  setUp(() {
    mockRepo = MockPopularTrainingRepository();
  });

  group('PopularTrainingRepository contract tests', () {
    test(
      'getAllExercises should return ApiResult<GetAllExercisesResponseEntity>',
      () async {
        // Arrange
        const request = GetAllExercisesRequestEntity(page: 1, limit: 10);

        const response = GetAllExercisesResponseEntity(
          message: 'Success',
          totalExercises: 1,
          totalPages: 1,
          currentPage: 1,
          exercises: [],
        );

        when(
          mockRepo.getAllExercises(request),
        ).thenAnswer((_) async => ApiSuccessResult(data: response));

        // Act
        final result = await mockRepo.getAllExercises(request);

        // Assert
        expect(result, isA<ApiSuccessResult<GetAllExercisesResponseEntity>>());
        verify(mockRepo.getAllExercises(request)).called(1);
      },
    );

    test('getAllExercises should return ApiFailureResult on error', () async {
      // Arrange
      const request = GetAllExercisesRequestEntity(page: 1, limit: 10);

      when(mockRepo.getAllExercises(request)).thenAnswer(
        (_) async => ApiErrorResult(failure: Failure(errorMessage: 'Error')),
      );

      // Act
      final result = await mockRepo.getAllExercises(request);

      // Assert
      expect(result, isA<ApiErrorResult<GetAllExercisesResponseEntity>>());
      verify(mockRepo.getAllExercises(request)).called(1);
    });
  });
}
