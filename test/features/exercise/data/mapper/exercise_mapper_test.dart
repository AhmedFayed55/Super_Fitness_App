import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/exercise/data/mapper/exercise_mapper.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/exercise_dto.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_difficulty_level/difficulty_level_dto.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';

void main() {
  group('ExerciseMapper', () {
    test('should map ExerciseDto to ExerciseEntity correctly', () {
      // arrange
      final dto = ExerciseDto(
        id: '1',
        exercise: 'Push Up',
        shortYoutubeDemonstration: 'demo',
        inDepthYoutubeExplanation: 'explain',
        difficultyLevel: 'Beginner',
        targetMuscleGroup: 'Chest',
        primeMoverMuscle: 'Pectoralis Major',
        secondaryMuscle: 'Triceps',
        tertiaryMuscle: 'Deltoids',
        primaryEquipment: 'Bodyweight',
        primaryItems: 0,
        secondaryEquipment: 'None',
        secondaryItems: 0,
        posture: 'Horizontal',
        singleOrDoubleArm: 'Double',
        continuousOrAlternatingArms: 'Continuous',
        grip: 'Neutral',
        loadPositionEnding: 'Front',
        continuousOrAlternatingLegs: 'Continuous',
        footElevation: 'None',
        combinationExercises: 'None',
        movementPattern1: 'Press',
        movementPattern2: 'Upper Body',
        movementPattern3: 'Compound',
        planeOfMotion1: 'Sagittal',
        planeOfMotion2: 'Frontal',
        planeOfMotion3: 'Transverse',
        bodyRegion: 'Upper',
        forceType: 'Push',
        mechanics: 'Compound',
        laterality: 'Bilateral',
        primaryExerciseClassification: 'Strength',
        shortYoutubeDemonstrationLink: 'demo_link',
        inDepthYoutubeExplanationLink: 'explain_link',
      );

      // act
      final entity = dto.toEntity();

      // assert
      expect(entity, isA<ExerciseEntity>());
      expect(entity.id, '1');
      expect(entity.exercise, 'Push Up');
      expect(entity.difficultyLevel, 'Beginner');
      expect(entity.primeMoverMuscle, 'Pectoralis Major');
      expect(entity.shortYoutubeDemonstrationLink, 'demo_link');
    });

    test('should handle null values safely', () {
      // arrange
      final dto = ExerciseDto();

      // act
      final entity = dto.toEntity();

      // assert
      expect(entity.id, '');
      expect(entity.exercise, '');
      expect(entity.secondaryMuscle, isNull);
      expect(entity.tertiaryMuscle, isNull);
    });
  });

  group('DifficultyLevelMapper', () {
    test(
      'should map DifficultyLevelDto to DifficultyLevelEntity correctly',
      () {
        // arrange
        final dto = DifficultyLevelDto(id: '2', name: 'Intermediate');

        // act
        final entity = dto.toEntity();

        // assert
        expect(entity, isA<DifficultyLevelEntity>());
        expect(entity.id, '2');
        expect(entity.name, 'Intermediate');
      },
    );

    test('should handle null values correctly', () {
      // arrange
      final dto = DifficultyLevelDto();

      // act
      final entity = dto.toEntity();

      // assert
      expect(entity.id, '');
      expect(entity.name, '');
    });
  });
}
