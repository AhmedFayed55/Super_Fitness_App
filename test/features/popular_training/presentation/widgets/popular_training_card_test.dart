import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/popular_training_card.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('PopularTrainingCard displays content and reacts to tap', (
    tester,
  ) async {
    bool tapped = false;

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PopularTrainingCard(
              imageUrl: 'https://example.com/image.jpg',
              title: 'Full Body Workout',
              level: 'Beginner',
              tasksCount: '5',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Full Body Workout'), findsOneWidget);
      expect(find.text('5 Tasks'), findsOneWidget);
      expect(find.text('Beginner'), findsOneWidget);

      final gestureFinder = find.byType(GestureDetector);
      expect(gestureFinder, findsOneWidget);

      await tester.tap(gestureFinder);
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });
  });
}
