import 'package:super_fitness_app/features/exercise/data/models/get_all_exerecises/exercise_dto.dart';
import 'package:super_fitness_app/features/exercise/data/models/get_difficulty_level/difficulty_level_dto.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/difficulty_level_entity.dart';
import 'package:super_fitness_app/features/exercise/domain/entity/exercise_entity.dart';

extension ExerciseMapper on ExerciseDto {
  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id ?? '',
      exercise: exercise ?? '',
      shortYoutubeDemonstration: shortYoutubeDemonstration,
      inDepthYoutubeExplanation: inDepthYoutubeExplanation,
      difficultyLevel: difficultyLevel,
      targetMuscleGroup: targetMuscleGroup,
      primeMoverMuscle: primeMoverMuscle,
      secondaryMuscle: secondaryMuscle?.toString(),
      tertiaryMuscle: tertiaryMuscle?.toString(),
      primaryEquipment: primaryEquipment,
      primaryItems: primaryItems,
      secondaryEquipment: secondaryEquipment?.toString(),
      secondaryItems: secondaryItems,
      posture: posture,
      singleOrDoubleArm: singleOrDoubleArm,
      continuousOrAlternatingArms: continuousOrAlternatingArms,
      grip: grip,
      loadPositionEnding: loadPositionEnding,
      continuousOrAlternatingLegs: continuousOrAlternatingLegs,
      footElevation: footElevation,
      combinationExercises: combinationExercises,
      movementPattern1: movementPattern1,
      movementPattern2: movementPattern2?.toString(),
      movementPattern3: movementPattern3?.toString(),
      planeOfMotion1: planeOfMotion1,
      planeOfMotion2: planeOfMotion2?.toString(),
      planeOfMotion3: planeOfMotion3?.toString(),
      bodyRegion: bodyRegion,
      forceType: forceType,
      mechanics: mechanics,
      laterality: laterality,
      primaryExerciseClassification: primaryExerciseClassification,
      shortYoutubeDemonstrationLink: shortYoutubeDemonstrationLink,
      inDepthYoutubeExplanationLink: inDepthYoutubeExplanationLink,
    );
  }
}

extension DifficultyLevelMapper on DifficultyLevelDto {
  DifficultyLevelEntity toEntity() {
    return DifficultyLevelEntity(id: id ?? '', name: name ?? '');
  }
}
