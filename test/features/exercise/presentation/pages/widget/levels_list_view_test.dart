import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/level_widget.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/levels_list_view.dart';

import 'levels_list_view_test.mocks.dart';

@GenerateMocks([ExerciseCubit])
void main() {
  late MockExerciseCubit mockCubit;

  setUp(() {
    mockCubit = MockExerciseCubit();
  });

  Widget makeTestableWidget(ExerciseState state) {
    when(mockCubit.state).thenReturn(state);
    return MaterialApp(
      home: BlocProvider<ExerciseCubit>.value(
        value: mockCubit,
        child: const Scaffold(body: LevelsListView()),
      ),
    );
  }

  group('LevelsListView Widget Tests', () {
    testWidgets('should render nothing when difficulties list is empty', (
      tester,
    ) async {
      // arrange
      final state = ExerciseState.initial();
      when(mockCubit.state).thenReturn(state);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(state));

      // act
      await tester.pumpWidget(makeTestableWidget(state));

      // assert
      expect(find.byType(LevelWidget), findsNothing);
    });

    testWidgets('should render one LevelWidget when one level exists', (
      tester,
    ) async {
      // arrange
      final oneLevel = [const DifficultyLevelEntity(id: '1', name: 'Beginner')];

      final state = ExerciseState.initial().copyWith(
        data: ExerciseData(
          difficulties: oneLevel,
          exercises: const [],
          selectedDifficultyId: '1',
        ),
      );

      when(mockCubit.state).thenReturn(state);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(state));

      // act
      await tester.pumpWidget(makeTestableWidget(state));

      // assert
      expect(find.byType(LevelWidget), findsOneWidget);
      expect(find.text('Beginner'), findsOneWidget);
    });

    testWidgets('should render multiple levels and handle tap correctly', (
      tester,
    ) async {
      // arrange
      final levels = [
        const DifficultyLevelEntity(id: '1', name: 'Easy'),
        const DifficultyLevelEntity(id: '2', name: 'Medium'),
        const DifficultyLevelEntity(id: '3', name: 'Hard'),
      ];

      final state = ExerciseState.initial().copyWith(
        data: ExerciseData(
          difficulties: levels,
          exercises: const [],
          selectedDifficultyId: '1',
        ),
      );

      when(mockCubit.state).thenReturn(state);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(state));

      // act
      await tester.pumpWidget(makeTestableWidget(state));

      // assert
      expect(find.byType(LevelWidget), findsNWidgets(3));
      expect(find.text('Medium'), findsOneWidget);

      // simulate tap
      await tester.tap(find.text('Medium'));
      await tester.pumpAndSettle();
      verify(mockCubit.doIntent(any)).called(1);
    });
  });
}
