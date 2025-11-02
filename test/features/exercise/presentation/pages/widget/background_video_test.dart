import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/exercise/presentation/manager/cubit/exercise_cubit.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/background_video.dart';

import 'background_video_test.mocks.dart';

@GenerateMocks([ExerciseCubit])
void main() {
  late MockExerciseCubit mockCubit;

  setUp(() {
    mockCubit = MockExerciseCubit();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<ExerciseCubit>.value(
        value: mockCubit,
        child: const Scaffold(body: BackgroundVideo()),
      ),
    );
  }

  group('BackgroundVideo Widget Tests', () {
    testWidgets('shows CircularProgressIndicator when controller is null', (
      tester,
    ) async {
      // Arrange
      when(
        mockCubit.state,
      ).thenReturn(ExerciseState.initial().copyWith(videoController: null));
      when(mockCubit.stream).thenAnswer((_) => Stream.value(mockCubit.state));

      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
