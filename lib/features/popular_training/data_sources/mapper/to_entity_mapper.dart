import 'package:super_fitness_app/features/popular_training/data_sources/models/exercise_dto.dart';
import 'package:super_fitness_app/features/popular_training/data_sources/models/response/get_all_exercises_response_dto.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/response/get_all_exercises_response_entity.dart';

extension PopularTrainingResponseMapper on GetAllExercisesResponseDto {
  GetAllExercisesResponseEntity toEntity() {
    return GetAllExercisesResponseEntity(
      message: message ?? 'success',
      totalExercises: totalExercises ?? 0,
      totalPages: totalPages ?? 0,
      currentPage: currentPage ?? 1,
      exercises: exercises?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension ExerciseMapper on ExerciseDto {
  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id ?? '',
      exercise: exercise ?? 'Unknown Exercise',
      shortYoutubeDemonstration:
          shortYoutubeDemonstration ?? 'Video Demonstration',
      inDepthYoutubeExplanation: inDepthYoutubeExplanation ?? '',
      difficultyLevel: difficultyLevel ?? 'مبتدئ',
      targetMuscleGroup: targetMuscleGroup ?? '',
      primeMoverMuscle: primeMoverMuscle ?? '',
      secondaryMuscle: secondaryMuscle ?? '',
      tertiaryMuscle: tertiaryMuscle ?? '',
      primaryEquipment: primaryEquipment ?? 'Bodyweight',
      primaryItems: primaryItems ?? 1,
      secondaryEquipment: secondaryEquipment ?? '',
      secondaryItems: secondaryItems ?? 0,
      posture: posture ?? '',
      singleOrDoubleArm: singleOrDoubleArm ?? '',
      continuousOrAlternatingArms: continuousOrAlternatingArms ?? 'Continuous',
      grip: grip ?? 'No Grip',
      loadPositionEnding: loadPositionEnding ?? 'No Load',
      continuousOrAlternatingLegs: continuousOrAlternatingLegs ?? 'Continuous',
      footElevation: footElevation ?? 'No Elevation',
      combinationExercises: combinationExercises ?? 'Single Exercise',
      movementPattern1: movementPattern1 ?? '',
      movementPattern2: movementPattern2 ?? '',
      movementPattern3: movementPattern3 ?? '',
      planeOfMotion1: planeOfMotion1 ?? '',
      planeOfMotion2: planeOfMotion2 ?? '',
      planeOfMotion3: planeOfMotion3 ?? '',
      bodyRegion: bodyRegion ?? '',
      forceType: forceType ?? '',
      mechanics: mechanics ?? '',
      laterality: laterality ?? '',
      primaryExerciseClassification: primaryExerciseClassification ?? '',
      shortYoutubeDemonstrationLink: shortYoutubeDemonstrationLink ?? '',
      inDepthYoutubeExplanationLink: inDepthYoutubeExplanationLink ?? '',
    );
  }
}
