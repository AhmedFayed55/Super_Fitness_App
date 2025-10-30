sealed class ExerciseEvent {}

class GetExercisesDifficultiesEvent extends ExerciseEvent {
  final String muscleId;
  GetExercisesDifficultiesEvent({required this.muscleId});
}

class SwitchExerciseEvent extends ExerciseEvent {

  final String difficultyId;
  SwitchExerciseEvent({required this.difficultyId});
}

class GetExercisesByDifficultyEvent extends ExerciseEvent {
  final String muscleId;
  final String difficultyId;
  GetExercisesByDifficultyEvent({required this.muscleId, required this.difficultyId});
}
