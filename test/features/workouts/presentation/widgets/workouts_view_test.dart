import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_view_model.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_state.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/workouts/presentation/widgets/workouts_view.dart';

class MockWorkoutsViewModel extends MockCubit<WorkoutsState>
    implements WorkoutsViewModel {}

void main() {
  late MockWorkoutsViewModel mockCubit;

  setUp(() {
    mockCubit = MockWorkoutsViewModel();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<WorkoutsViewModel>.value(
        value: mockCubit,
        child: child,
      ),
    );
  }

  group('WorkoutsView Widget Tests', () {
    testWidgets('shows muscle group tabs when loaded', (tester) async {
      final mockGroups = [
        MusclesGroupDtoEntity(id: '1', name: 'Chest'),
        MusclesGroupDtoEntity(id: '2', name: 'Legs'),
      ];

      when(() => mockCubit.state).thenReturn(
        WorkoutsState(
          muscleGroups: mockGroups,
          selectedMuscleGroupIndex: 0,
          isLoadingGroups: false,
        ),
      );

      await tester.pumpWidget(makeTestableWidget(const WorkoutsView()));
      await tester.pump();

      expect(find.text('Chest'), findsOneWidget);
      expect(find.text('Legs'), findsOneWidget);
    });

    testWidgets('shows no exercises message when exercises list is empty', (
      tester,
    ) async {
      final state = WorkoutsState(
        isLoadingGroups: false,
        isLoadingExercises: false,
        exercises: const [],
        muscleGroups: [MusclesGroupDtoEntity(id: '1', name: 'Chest')],
        selectedMuscleGroupIndex: 0,
      );

      when(() => mockCubit.state).thenReturn(state);

      await tester.pumpWidget(makeTestableWidget(const WorkoutsView()));
      await tester.pump();

      expect(find.textContaining('No exercises'), findsOneWidget);
      expect(find.byIcon(Icons.fitness_center_rounded), findsOneWidget);
    });

    testWidgets('shows exercise grid when exercises are loaded', (
      tester,
    ) async {
      final exercises = [
        MusclesDtoEntity(id: '1', name: 'Push Up', image: 'url1'),
        MusclesDtoEntity(id: '2', name: 'Squat', image: 'url2'),
      ];

      when(() => mockCubit.state).thenReturn(
        WorkoutsState(
          isLoadingGroups: false,
          isLoadingExercises: false,
          exercises: exercises,
          muscleGroups: [MusclesGroupDtoEntity(id: '1', name: 'Chest')],
          selectedMuscleGroupIndex: 0,
        ),
      );

      await tester.pumpWidget(makeTestableWidget(const WorkoutsView()));
      await tester.pump();

      expect(find.text('Push Up'), findsOneWidget);
      expect(find.text('Squat'), findsOneWidget);
    });
  });
}
