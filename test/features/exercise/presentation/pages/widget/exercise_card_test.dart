import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/exercise/presentation/pages/widget/exercise_card.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';

void main() {
  const fakeExercise = ExerciseEntity(
    id: "1",
    exercise: "Push Ups",
    primeMoverMuscle: "chest",
    shortYoutubeDemonstrationLink:
        "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
  );

  testWidgets('renders ExerciseCard correctly without testing video popup', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ExerciseCard(exercise: fakeExercise)),
      ),
    );

    expect(find.text("Push Ups"), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
  });
}
