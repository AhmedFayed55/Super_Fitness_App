import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:super_fitness_app/core/utils/enums.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';
import 'package:super_fitness_app/features/popular_training/presentation/manager/cubit/popular_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/popular_training_card.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/popular_training_list_view_builder.dart';

void main() {
  testWidgets(
    'PopularTrainingListViewBuilder displays correct number of cards and reacts to tap',
    (tester) async {
      // Arrange
      final fakeData = [
        const PopularData(
          level: Level.beginner,
          exercises: [
            ExerciseEntity(
              primeMoverMuscle: 'Chest',
              inDepthYoutubeExplanationLink: 'https://example.com/video1',
              id: '',
              exercise: '',
            ),
          ],
        ),
        const PopularData(
          level: Level.advanced,
          exercises: [
            ExerciseEntity(
              primeMoverMuscle: 'Legs',
              shortYoutubeDemonstrationLink: 'https://example.com/video2',
              id: '',
              exercise: '',
            ),
          ],
        ),
      ];

      // Act
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PopularTrainingListViewBuilder(data: fakeData),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Assert
        expect(
          find.byType(PopularTrainingCard),
          findsNWidgets(fakeData.length),
        );

        expect(find.text('Chest'), findsOneWidget);
        expect(find.text('Legs'), findsOneWidget);
        expect(find.text('beginner'), findsOneWidget);
        expect(find.text('advanced'), findsOneWidget);
      });
    },
  );
}
