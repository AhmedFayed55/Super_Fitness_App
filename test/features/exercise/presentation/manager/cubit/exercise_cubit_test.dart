import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/network/api_results.dart';
import 'package:super_fitness_app/core/network/failures.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/usecase/get_all_exercises_by_difficulty_usecase.dart';
import 'package:super_fitness_app/features/exercise/domain/usecase/get_exercises_difficultes_by_muscle_usecase.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';

import 'exercise_cubit_test.mocks.dart';

@GenerateMocks([
  GetAllExercisesByDifficultyUsecase,
  GetExercisesDifficultesByMuscleUsecase,
])
void main() {
  late MockGetAllExercisesByDifficultyUsecase
  mockGetAllExercisesByDifficultyUsecase;
  late MockGetExercisesDifficultesByMuscleUsecase
  mockGetExercisesDifficultesByMuscleUsecase;
  late ExerciseCubit cubit;

  setUp(() {
    mockGetAllExercisesByDifficultyUsecase =
        MockGetAllExercisesByDifficultyUsecase();
    mockGetExercisesDifficultesByMuscleUsecase =
        MockGetExercisesDifficultesByMuscleUsecase();
    cubit = ExerciseCubit(
      mockGetAllExercisesByDifficultyUsecase,
      mockGetExercisesDifficultesByMuscleUsecase,
    );

    provideDummy<ApiResult<List<DifficultyLevelEntity>>>(
      ApiSuccessResult(data: []),
    );
    provideDummy<ApiResult<List<ExerciseEntity>>>(ApiSuccessResult(data: []));
  });

  tearDown(() async {
    await cubit.close();
  });

  group('ExerciseCubit Tests', () {
    const testMuscleId = 'm1';
    const testDifficultyId = 'd1';

    const difficulty = DifficultyLevelEntity(
      id: testDifficultyId,
      name: 'Easy',
    );
    const exercise = ExerciseEntity(
      id: 'e1',
      exercise: 'Push Up',
      targetMuscleGroup: 'Chest',
      shortYoutubeDemonstrationLink: null,
    );

    test('initial state should be ExerciseState.initial()', () {
      expect(cubit.state, ExerciseState.initial());
    });

    blocTest<ExerciseCubit, ExerciseState>(
      'emits 4 states when getExercisesDifficultiesByMuscle succeeds',
      build: () {
        when(
          mockGetExercisesDifficultesByMuscleUsecase.invoke(testMuscleId),
        ).thenAnswer((_) async => ApiSuccessResult(data: [difficulty]));

        when(
          mockGetAllExercisesByDifficultyUsecase.invoke(
            testMuscleId,
            testDifficultyId,
          ),
        ).thenAnswer((_) async => ApiSuccessResult(data: [exercise]));

        return cubit;
      },
      act: (cubit) => cubit.getExercisesDifficultiesByMuscle(testMuscleId),
      expect: () => [
        isA<ExerciseState>().having(
          (s) => s.loadingStatus.isScreenLoading,
          'screen loading',
          true,
        ),

        isA<ExerciseState>().having(
          (s) => s.successStatus.isScreenSuccess,
          'screen success',
          true,
        ),

        isA<ExerciseState>().having(
          (s) => s.loadingStatus.isExercisesLoading,
          'exercises loading',
          true,
        ),

        isA<ExerciseState>().having(
          (s) => s.successStatus.isExercisesSuccess,
          'exercises success',
          true,
        ),
      ],
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'emits error when getExercisesDifficultiesByMuscle fails',
      build: () {
        when(
          mockGetExercisesDifficultesByMuscleUsecase.invoke(testMuscleId),
        ).thenAnswer(
          (_) async => ApiErrorResult(failure: Failure(errorMessage: 'error')),
        );
        return cubit;
      },
      act: (cubit) => cubit.getExercisesDifficultiesByMuscle(testMuscleId),
      expect: () => [
        isA<ExerciseState>().having(
          (s) => s.loadingStatus.isScreenLoading,
          'loading',
          true,
        ),
        isA<ExerciseState>().having(
          (s) => s.errorMessage.screenErrorMessage,
          'error',
          'error',
        ),
      ],
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'emits success when getExercisesByDifficulty succeeds',
      build: () {
        when(
          mockGetAllExercisesByDifficultyUsecase.invoke(
            testMuscleId,
            testDifficultyId,
          ),
        ).thenAnswer((_) async => ApiSuccessResult(data: [exercise]));
        return cubit;
      },
      act: (cubit) =>
          cubit.getExercisesByDifficulty(testMuscleId, testDifficultyId),
      expect: () => [
        isA<ExerciseState>().having(
          (s) => s.loadingStatus.isExercisesLoading,
          'loading',
          true,
        ),
        isA<ExerciseState>().having(
          (s) => s.successStatus.isExercisesSuccess,
          'success',
          true,
        ),
      ],
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'emits error when getExercisesByDifficulty fails',
      build: () {
        when(
          mockGetAllExercisesByDifficultyUsecase.invoke(
            testMuscleId,
            testDifficultyId,
          ),
        ).thenAnswer(
          (_) async => ApiErrorResult(failure: Failure(errorMessage: 'failed')),
        );
        return cubit;
      },
      act: (cubit) =>
          cubit.getExercisesByDifficulty(testMuscleId, testDifficultyId),
      expect: () => [
        isA<ExerciseState>().having(
          (s) => s.loadingStatus.isExercisesLoading,
          'loading',
          true,
        ),
        isA<ExerciseState>().having(
          (s) => s.errorMessage.exercisesErrorMessage,
          'error',
          'failed',
        ),
      ],
    );
  });
}
