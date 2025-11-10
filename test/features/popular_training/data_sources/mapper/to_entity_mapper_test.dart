import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/exercise_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/mapper/to_entity_mapper.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/response/get_all_exercises_response_dto.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/response/get_all_exercises_response_entity.dart';

void main() {
  group('PopularTrainingResponseMapper Tests', () {
    test(
      'GetAllExercisesResponseDto → GetAllExercisesResponseEntity mapping should be correct',
      () {
        final mockDto = GetAllExercisesResponseDto(
          message: 'Fetched successfully',
          totalExercises: 5,
          totalPages: 1,
          currentPage: 1,
          exercises: [
            ExerciseDto(
              id: '1',
              exercise: 'Push Up',
              difficultyLevel: 'Medium',
              primaryEquipment: 'Bodyweight',
              primaryItems: 0,
              shortYoutubeDemonstrationLink: 'https://yt.com/demo',
            ),
          ],
        );

        final result = mockDto.toEntity();

        expect(result, isA<GetAllExercisesResponseEntity>());
        expect(result.message, equals('Fetched successfully'));
        expect(result.totalExercises, equals(5));
        expect(result.exercises.first.exercise, equals('Push Up'));
      },
    );

    test(
      'GetAllExercisesResponseDto → GetAllExercisesResponseEntity should handle null fields gracefully',
      () {
        final mockDto = GetAllExercisesResponseDto(
          message: null,
          totalExercises: null,
          totalPages: null,
          currentPage: null,
          exercises: null,
        );

        final result = mockDto.toEntity();

        expect(result.message, equals('success'));
        expect(result.totalExercises, equals(0));
        expect(result.totalPages, equals(0));
        expect(result.currentPage, equals(1));
        expect(result.exercises, isEmpty);
      },
    );
  });
}
