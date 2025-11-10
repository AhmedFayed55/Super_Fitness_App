import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/repo/exercise_repo.dart';
import 'package:super_fitness_app/features/exercise/domain/usecase/get_all_exercises_by_difficulty_usecase.dart';

import 'get_all_exercises_by_difficulty_usecase_test.mocks.dart';

@GenerateMocks([ExerciseRepo])
void main() {
  late GetAllExercisesByDifficultyUsecase usecase;
  late MockExerciseRepo mockRepo;

  provideDummy<ApiResult<List<ExerciseEntity>>>(ApiSuccessResult(data: []));

  setUp(() {
    mockRepo = MockExerciseRepo();
    usecase = GetAllExercisesByDifficultyUsecase(mockRepo);
  });

  group('GetAllExercisesByDifficultyUsecase', () {
    test(
      'should call repo.getAllExercisesByDifficulty with correct params and return ApiResult.success',
      () async {
        // arrange
        final exercises = [const ExerciseEntity(id: '1', exercise: 'Push Up')];
        final expectedResult = ApiSuccessResult(data: exercises);

        when(
          mockRepo.getAllExercisesByDifficulty('10', '20'),
        ).thenAnswer((_) async => expectedResult);

        // act
        final result = await usecase.invoke('10', '20');

        // assert
        verify(mockRepo.getAllExercisesByDifficulty('10', '20')).called(1);
        expect(result, equals(expectedResult));
      },
    );

    test('should propagate failure from repo', () async {
      // arrange
      final failureResult = ApiErrorResult<List<ExerciseEntity>>(
        failure: Failure(errorMessage: 'Network Error'),
      );
      when(
        mockRepo.getAllExercisesByDifficulty('5', '6'),
      ).thenAnswer((_) async => failureResult);

      // act
      final result = await usecase.invoke('5', '6');

      // assert
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).failure.errorMessage, 'Network Error');
    });
  });
}
