import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/workouts/presentation/widgets/exercise_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    CachedNetworkImage.logLevel = CacheManagerLogLevel.none;
  });

  group('ExerciseCard Widget', () {
    testWidgets('renders exercise name and triggers onTap', (tester) async {
      final exercise = MusclesDtoEntity(
        id: '1',
        name: 'Push Up',
        image: 'https://example.com/pushup.png',
      );

      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseCard(
              exercise: exercise,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Push Up'), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      await tester.tap(find.byType(ExerciseCard));
      await tester.pump(const Duration(milliseconds: 100));

      expect(tapped, isTrue);
    });

    testWidgets('shows placeholder while loading', (tester) async {
      final exercise = MusclesDtoEntity(
        id: '2',
        name: 'Squat',
        image: 'https://fakeurl.com/image.png',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseCard(exercise: exercise, onTap: () {}),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error icon if image fails', (tester) async {
      final exercise = MusclesDtoEntity(
        id: '3',
        name: 'Plank',
        image: 'invalid_url',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseCard(exercise: exercise, onTap: () {}),
          ),
        ),
      );

      final errorBuilder =
          tester
              .widget<CachedNetworkImage>(find.byType(CachedNetworkImage))
              .errorWidget!(
            tester.element(find.byType(CachedNetworkImage)),
            '',
            '',
          );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: errorBuilder)));

      expect(find.byIcon(Icons.fitness_center), findsOneWidget);
    });
  });
}
