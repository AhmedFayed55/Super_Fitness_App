part of 'exercise_cubit.dart';

class ExerciseState extends Equatable {
  final ExerciseLodaingStatus loadingStatus;
  final ExerciseSuccessStatus successStatus;
  final ExerciseErrorMessage errorMessage;
  final String? selectedMuscleId;
  final ExerciseData data;
  final YoutubePlayerController? videoController;

  const ExerciseState({
    this.selectedMuscleId,
    required this.loadingStatus,
    required this.successStatus,
    required this.errorMessage,
    required this.data,
    this.videoController,
  });

  factory ExerciseState.initial() => const ExerciseState(
        selectedMuscleId: null,
        loadingStatus: ExerciseLodaingStatus(
          isScreenLoading: false,
          isExercisesLoading: false,
        ),
        successStatus: ExerciseSuccessStatus(
          isScreenSuccess: false,
          isExercisesSuccess: false,
        ),
        errorMessage: ExerciseErrorMessage(
          screenErrorMessage: null,
          exercisesErrorMessage: null,
        ),
        data: ExerciseData(
          difficulties: [],
          exercises: [],
          selectedDifficultyId: null,
        ),
        videoController: null,
      );

  ExerciseState copyWith({
    String? selectedMuscleId,
    ExerciseLodaingStatus? loadingStatus,
    ExerciseSuccessStatus? successStatus,
    ExerciseErrorMessage? errorMessage,
    ExerciseData? data,
    YoutubePlayerController? videoController,
  }) {
    return ExerciseState(
      selectedMuscleId: selectedMuscleId ?? this.selectedMuscleId,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      successStatus: successStatus ?? this.successStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      videoController: videoController ?? this.videoController,
    );
  }

  @override
  List<Object?> get props => [
        selectedMuscleId,
        loadingStatus,
        successStatus,
        errorMessage,
        data,
        videoController,
      ];
}

class ExerciseData extends Equatable {
  final List<DifficultyLevelEntity> difficulties;
  final List<ExerciseEntity> exercises;
  final String? selectedDifficultyId;

  const ExerciseData({
    required this.difficulties,
    required this.exercises,
    this.selectedDifficultyId,
  });

  ExerciseData copyWith({
    List<DifficultyLevelEntity>? difficulties,
    List<ExerciseEntity>? exercises,
    String? selectedDifficultyId,
  }) {
    return ExerciseData(
      difficulties: difficulties ?? this.difficulties,
      exercises: exercises ?? this.exercises,
      selectedDifficultyId: selectedDifficultyId ?? this.selectedDifficultyId,
    );
  }

  @override
  List<Object?> get props => [
        difficulties,
        exercises,
        selectedDifficultyId,
      ];
}

class ExerciseLodaingStatus extends Equatable {
  final bool isScreenLoading;
  final bool isExercisesLoading;

  const ExerciseLodaingStatus({
    required this.isScreenLoading,
    required this.isExercisesLoading,
  });

  ExerciseLodaingStatus copyWith({
    bool? isScreenLoading,
    bool? isExercisesLoading,
  }) {
    return ExerciseLodaingStatus(
      isScreenLoading: isScreenLoading ?? this.isScreenLoading,
      isExercisesLoading: isExercisesLoading ?? this.isExercisesLoading,
    );
  }

  @override
  List<Object?> get props => [
        isScreenLoading,
        isExercisesLoading,
      ];
}

class ExerciseErrorMessage extends Equatable {
  final String? screenErrorMessage;
  final String? exercisesErrorMessage;

  const ExerciseErrorMessage({
    this.screenErrorMessage,
    this.exercisesErrorMessage,
  });

  ExerciseErrorMessage copyWith({
    String? screenErrorMessage,
    String? exercisesErrorMessage,
  }) {
    return ExerciseErrorMessage(
      screenErrorMessage: screenErrorMessage ?? this.screenErrorMessage,
      exercisesErrorMessage: exercisesErrorMessage ?? this.exercisesErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        screenErrorMessage,
        exercisesErrorMessage,
      ];
}

class ExerciseSuccessStatus extends Equatable {
  final bool isScreenSuccess;
  final bool isExercisesSuccess;

  const ExerciseSuccessStatus({
    required this.isScreenSuccess,
    required this.isExercisesSuccess,
  });

  ExerciseSuccessStatus copyWith({
    bool? isScreenSuccess,
    bool? isExercisesSuccess,
  }) {
    return ExerciseSuccessStatus(
      isScreenSuccess: isScreenSuccess ?? this.isScreenSuccess,
      isExercisesSuccess: isExercisesSuccess ?? this.isExercisesSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isScreenSuccess,
        isExercisesSuccess,
      ];
}
