import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/exercise_body.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/shammer_loading.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/exercise_screen.dart';

import 'widget/background_video_test.mocks.dart';

@GenerateMocks([ExerciseCubit])
void main() {
  late MockExerciseCubit mockCubit;

  setUp(() {
    mockCubit = MockExerciseCubit();
    if (getIt.isRegistered<ExerciseCubit>()) {
      getIt.unregister<ExerciseCubit>();
    }
    getIt.registerLazySingleton<ExerciseCubit>(() => mockCubit);
  });

  tearDown(() {
    if (getIt.isRegistered<ExerciseCubit>()) {
      getIt.unregister<ExerciseCubit>();
    }
  });

  Widget createTestWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ExerciseCubit>.value(
        value: mockCubit,
        child: ExerciseScreen.byPreloadedData(
          exercises: const [
            ExerciseEntity(
              id: '1',
              exercise: 'Push Up',
              targetMuscleGroup: 'Chest',
            ),
          ],
          difficulties: const [DifficultyLevelEntity(id: '1', name: 'Easy')],
        ),
      ),
    );
  }

  group('ExerciseScreen Widget Tests', () {
    testWidgets('shows shimmer when loading', (tester) async {
      when(mockCubit.state).thenReturn(
        ExerciseState.initial().copyWith(
          loadingStatus: const ExerciseLodaingStatus(
            isScreenLoading: true,
            isExercisesLoading: true,
          ),
        ),
      );
      when(mockCubit.stream).thenAnswer((_) => Stream.value(mockCubit.state));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(ExerciseShimmerScreen), findsOneWidget);
    });

    testWidgets('shows error message when error occurs', (tester) async {
      when(mockCubit.state).thenReturn(
        ExerciseState.initial().copyWith(
          errorMessage: const ExerciseErrorMessage(
            screenErrorMessage: 'Error occurred',
          ),
        ),
      );
      when(mockCubit.stream).thenAnswer((_) => Stream.value(mockCubit.state));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Error occurred'), findsOneWidget);
    });

    testWidgets('shows ExerciseBody when data loaded successfully', (
      tester,
    ) async {
      when(mockCubit.state).thenReturn(
        ExerciseState.initial().copyWith(
          successStatus: const ExerciseSuccessStatus(
            isScreenSuccess: true,
            isExercisesSuccess: true,
          ),
          data: const ExerciseData(
            exercises: [
              ExerciseEntity(
                id: '1',
                exercise: 'Push Up',
                targetMuscleGroup: 'Chest',
              ),
            ],
            difficulties: [DifficultyLevelEntity(id: '1', name: 'Easy')],
          ),
        ),
      );
      when(mockCubit.stream).thenAnswer((_) => Stream.value(mockCubit.state));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(ExerciseBody), findsOneWidget);
    });
  });
}
