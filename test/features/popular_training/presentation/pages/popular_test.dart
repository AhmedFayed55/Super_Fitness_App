import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/popular_training/presentation/manager/cubit/popular_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/pages/popular.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/loading_widget.dart';

import 'popular_test.mocks.dart';

@GenerateMocks([PopularCubit])
void main() {
  late MockPopularCubit mockCubit;

  setUp(() {
    mockCubit = MockPopularCubit();
    if (!getIt.isRegistered<PopularCubit>()) {
      getIt.registerLazySingleton<PopularCubit>(() => mockCubit);
    }
  });

  Widget createTestWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<PopularCubit>.value(
          value: mockCubit,
          child: Popular(),
        ),
      ),
    );
  }

  group('Popular Widget Tests', () {
    testWidgets('shows shimmer when loading', (tester) async {
      when(mockCubit.state).thenReturn(const PopularState(isLoading: true));
      when(
        mockCubit.stream,
      ).thenAnswer((_) => Stream.value(const PopularState(isLoading: true)));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(PopularTrainingShimmer), findsOneWidget);
    });

    testWidgets('shows list when success and data available', (tester) async {
      final List<PopularData> popularData = [
        const PopularData(
          exercises: [
            ExerciseEntity(difficultyLevel: 'Beginner', id: '', exercise: ''),
            ExerciseEntity(difficultyLevel: 'Beginner', id: '', exercise: ''),
          ],
          level: Level.beginner,
        ),
      ];

      when(
        mockCubit.state,
      ).thenReturn(PopularState(isSuccess: true, popularData: popularData));
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          PopularState(isSuccess: true, popularData: popularData),
        ),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(ListView), findsWidgets);
    });
  });
}
