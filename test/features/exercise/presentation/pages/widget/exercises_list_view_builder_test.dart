import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/exercises_list_view_builder.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/list_lodaing_shammer.dart';

import 'levels_list_view_test.mocks.dart';

@GenerateMocks([ExerciseCubit])
void main() {
  group('ExercisesListViewBuilder Widget Test', () {
    late ExerciseCubit exerciseCubit;

    setUp(() {
      exerciseCubit = MockExerciseCubit();
    });

    Widget createTestWidget() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider.value(
          value: exerciseCubit,
          child: const Scaffold(
            body: Column(children: [ExercisesListViewBuilder()]),
          ),
        ),
      );
    }

    testWidgets('shows shimmer when loading', (tester) async {
      // Arrange
      when(exerciseCubit.state).thenReturn(
        ExerciseState.initial().copyWith(
          loadingStatus: const ExerciseLodaingStatus(
            isScreenLoading: false,
            isExercisesLoading: true,
          ),
        ),
      );

      when(exerciseCubit.stream).thenAnswer(
        (_) => Stream.value(
          ExerciseState.initial().copyWith(
            loadingStatus: const ExerciseLodaingStatus(
              isScreenLoading: false,
              isExercisesLoading: true,
            ),
          ),
        ),
      );

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.byType(ExerciseListShimmer), findsOneWidget);
    });

    testWidgets('shows error message when error occurs', (tester) async {
      when(exerciseCubit.state).thenReturn(
        ExerciseState.initial().copyWith(
          loadingStatus: const ExerciseLodaingStatus(
            isScreenLoading: false,
            isExercisesLoading: false,
          ),
          errorMessage: const ExerciseErrorMessage(
            exercisesErrorMessage: 'Failed to load exercises',
          ),
        ),
      );

      when(exerciseCubit.stream).thenAnswer(
        (_) => Stream.value(
          ExerciseState.initial().copyWith(
            loadingStatus: const ExerciseLodaingStatus(
              isScreenLoading: false,
              isExercisesLoading: false,
            ),
            errorMessage: const ExerciseErrorMessage(
              exercisesErrorMessage: 'Failed to load exercises',
            ),
          ),
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Failed to load exercises'), findsOneWidget);
    });

    testWidgets('shows list of exercises when success', (tester) async {
      const exercises = ExerciseData(
        difficulties: [
          DifficultyLevelEntity(id: '1', name: 'Push Up'),
          DifficultyLevelEntity(id: '2', name: 'Pull Up'),
        ],
        exercises: [
          ExerciseEntity(id: '1', exercise: 'Push Up'),
          ExerciseEntity(id: '2', exercise: 'Pull Up'),
        ],
      );

      when(exerciseCubit.state).thenReturn(
        ExerciseState.initial().copyWith(
          loadingStatus: const ExerciseLodaingStatus(
            isScreenLoading: false,
            isExercisesLoading: false,
          ),
          successStatus: const ExerciseSuccessStatus(
            isExercisesSuccess: true,
            isScreenSuccess: false,
          ),
          data: exercises,
        ),
      );

      when(exerciseCubit.stream).thenAnswer(
        (_) => Stream.value(
          ExerciseState.initial().copyWith(
            loadingStatus: const ExerciseLodaingStatus(
              isScreenLoading: false,
              isExercisesLoading: false,
            ),
            successStatus: const ExerciseSuccessStatus(
              isExercisesSuccess: true,
              isScreenSuccess: false,
            ),
            data: exercises,
          ),
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Push Up'), findsOneWidget);
      expect(find.text('Pull Up'), findsOneWidget);
    });

    testWidgets('shows empty message when exercises list is empty', (
      tester,
    ) async {
      when(exerciseCubit.state).thenReturn(
        ExerciseState.initial().copyWith(
          loadingStatus: const ExerciseLodaingStatus(
            isScreenLoading: false,
            isExercisesLoading: false,
          ),
          data: const ExerciseData(difficulties: [], exercises: []),
        ),
      );

      when(exerciseCubit.stream).thenAnswer(
        (_) => Stream.value(
          ExerciseState.initial().copyWith(
            loadingStatus: const ExerciseLodaingStatus(
              isScreenLoading: false,
              isExercisesLoading: false,
            ),
            data: const ExerciseData(difficulties: [], exercises: []),
          ),
        ),
      );
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(
        find.textContaining('no_exercises_available', findRichText: true),
        findsNothing,
      );
    });
  });
}
