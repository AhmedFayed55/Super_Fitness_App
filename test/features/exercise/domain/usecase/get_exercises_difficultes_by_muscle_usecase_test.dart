import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/repo/exercise_repo.dart';
import 'package:super_fitness_app/features/exercise/domain/usecase/get_exercises_difficultes_by_muscle_usecase.dart';

import 'get_exercises_difficultes_by_muscle_usecase_test.mocks.dart';

@GenerateMocks([ExerciseRepo])
void main() {
  late GetExercisesDifficultesByMuscleUsecase usecase;
  late MockExerciseRepo mockRepo;

  provideDummy<ApiResult<List<DifficultyLevelEntity>>>(
    ApiSuccessResult(data: []),
  );

  setUp(() {
    mockRepo = MockExerciseRepo();
    usecase = GetExercisesDifficultesByMuscleUsecase(exerciseRepo: mockRepo);
  });

  group('GetExercisesDifficultesByMuscleUsecase', () {
    test(
      'should call repo.getExerciseDifficultesByMuscle with correct param and return ApiResult.success',
      () async {
        // arrange
        final difficulties = [
          const DifficultyLevelEntity(id: '1', name: 'Beginner'),
        ];
        final expectedResult = ApiSuccessResult(data: difficulties);

        when(
          mockRepo.getExerciseDifficultesByMuscle('5'),
        ).thenAnswer((_) async => expectedResult);

        // act
        final result = await usecase.invoke('5');

        // assert
        verify(mockRepo.getExerciseDifficultesByMuscle('5')).called(1);
        expect(result, equals(expectedResult));
      },
    );

    test('should propagate failure from repo', () async {
      // arrange
      final failureResult = ApiErrorResult<List<DifficultyLevelEntity>>(
        failure: Failure(errorMessage: 'Server Error'),
      );

      when(
        mockRepo.getExerciseDifficultesByMuscle('99'),
      ).thenAnswer((_) async => failureResult);

      // act
      final result = await usecase.invoke('99');

      // assert
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).failure.errorMessage, 'Server Error');
    });
  });
}
