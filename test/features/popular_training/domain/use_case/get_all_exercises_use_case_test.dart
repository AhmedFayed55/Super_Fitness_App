import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/request/get_all_exercises_request_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/response/get_all_exercises_response_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repositories/popular_training_repo.dart';
import 'package:super_fitness_app/features/popular_training/domain/use_case/get_all_exercises_use_case.dart';

import 'get_all_exercises_use_case_test.mocks.dart';

@GenerateMocks([PopularTrainingRepository])
void main() {
  late MockPopularTrainingRepository mockRepo;
  late GetAllExercisesUseCase useCase;

  setUp(() {
    mockRepo = MockPopularTrainingRepository();
    useCase = GetAllExercisesUseCase(mockRepo);
  });

  test('should call repo.getAllExercises() and return success', () async {
    // Arrange
    const request = GetAllExercisesRequestEntity(page: 1, limit: 10);

    const response = GetAllExercisesResponseEntity(
      message: 'Success',
      totalExercises: 1,
      totalPages: 1,
      currentPage: 1,
      exercises: [
        ExerciseEntity(
          id: '1',
          exercise: 'Push Up',
          shortYoutubeDemonstration: 'Short demo',
          inDepthYoutubeExplanation: 'Full explanation',
          difficultyLevel: 'Medium',
          targetMuscleGroup: 'Chest',
          primeMoverMuscle: 'Pectoralis Major',
          secondaryMuscle: 'Triceps',
          tertiaryMuscle: 'Deltoids',
          primaryEquipment: 'Bodyweight',
          primaryItems: 0,
          secondaryEquipment: 'None',
          secondaryItems: 0,
          posture: 'Horizontal',
          singleOrDoubleArm: 'Double',
          continuousOrAlternatingArms: 'Continuous',
          grip: 'Neutral',
          loadPositionEnding: 'Bodyweight',
          continuousOrAlternatingLegs: 'None',
          footElevation: 'None',
          combinationExercises: 'None',
          movementPattern1: 'Push',
          movementPattern2: '',
          movementPattern3: '',
          planeOfMotion1: 'Sagittal',
          planeOfMotion2: '',
          planeOfMotion3: '',
          bodyRegion: 'Upper',
          forceType: 'Push',
          mechanics: 'Compound',
          laterality: 'Bilateral',
          primaryExerciseClassification: 'Strength',
          shortYoutubeDemonstrationLink: 'https://youtube.com/demo',
          inDepthYoutubeExplanationLink: 'https://youtube.com/full',
        ),
      ],
    );

    provideDummy<ApiResult<GetAllExercisesResponseEntity>>(
      ApiSuccessResult(data: response),
    );

    when(
      mockRepo.getAllExercises(any),
    ).thenAnswer((_) async => ApiSuccessResult(data: response));

    // Act
    final result = await useCase.invoke(request);

    // Assert
    verify(mockRepo.getAllExercises(any)).called(1);
    expect(result, isA<ApiSuccessResult<GetAllExercisesResponseEntity>>());

    final success = result as ApiSuccessResult<GetAllExercisesResponseEntity>;
    expect(success.data.message, equals('Success'));
    expect(success.data.exercises.first.exercise, equals('Push Up'));
  });

  test('should return failure when repo.getAllExercises() fails', () async {
    // Arrange
    const request = GetAllExercisesRequestEntity(page: 1);

    provideDummy<ApiResult<GetAllExercisesResponseEntity>>(
      ApiErrorResult(failure: Failure(errorMessage: 'Network error')),
    );

    when(mockRepo.getAllExercises(any)).thenAnswer(
      (_) async =>
          ApiErrorResult(failure: Failure(errorMessage: 'Network error')),
    );

    // Act
    final result = await useCase.invoke(request);

    // Assert
    verify(mockRepo.getAllExercises(any)).called(1);
    expect(result, isA<ApiErrorResult<GetAllExercisesResponseEntity>>());

    final failure = result as ApiErrorResult<GetAllExercisesResponseEntity>;
    expect(failure.failure.errorMessage, equals('Network error'));
  });
}
