import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/exercise_body.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/background_video.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/levels_list_view.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/exercises_list_view_builder.dart';

import 'exercises_list_view_builder_test.mocks.dart';

void main() {
  group('ExerciseBody Widget Test', () {
    late ExerciseCubit exerciseCubit;

    setUp(() {
      exerciseCubit = MockExerciseCubit();
    });
    Widget createTestWidget() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider(
            create: (context) => exerciseCubit,
            child: const ExerciseBody(),
          ),
        ),
      );
    }

    testWidgets(
      'renders BackgroundVideo, LevelsListView, and ExercisesListViewBuilder',
      (WidgetTester tester) async {
        // Arrange
        when(exerciseCubit.state).thenReturn(
          ExerciseState.initial().copyWith(
            loadingStatus: const ExerciseLodaingStatus(
              isScreenLoading: false,
              isExercisesLoading: false,
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
            ),
          ),
        );

        await tester.pumpWidget(createTestWidget());

        // Act
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(find.byType(BackgroundVideo), findsOneWidget);
        expect(find.byType(LevelsListView), findsOneWidget);
        expect(find.byType(ExercisesListViewBuilder), findsOneWidget);
      },
    );

    testWidgets('renders widgets inside a Column', (WidgetTester tester) async {
      when(exerciseCubit.state).thenReturn(
        ExerciseState.initial().copyWith(
          loadingStatus: const ExerciseLodaingStatus(
            isScreenLoading: false,
            isExercisesLoading: false,
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
          ),
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump(const Duration(milliseconds: 100));

      final columnFinder = find.byType(Column);
      expect(columnFinder, findsOneWidget);

      final columnWidget = tester.widget<Column>(columnFinder);

      expect(columnWidget.children.length, 4);
    });
  });
}
