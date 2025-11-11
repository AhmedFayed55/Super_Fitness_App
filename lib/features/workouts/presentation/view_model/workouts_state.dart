import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';

class WorkoutsState extends Equatable {
  final List<MusclesGroupDtoEntity> muscleGroups;
  final int selectedMuscleGroupIndex;
  final MuscleGroupDtoEntity? selectedMuscleGroup;
  final List<MusclesDtoEntity> exercises;
  final bool isLoadingGroups;
  final bool isLoadingExercises;
  final String? error;
  final String? exercisesError;

  const WorkoutsState({
    this.muscleGroups = const [],
    this.selectedMuscleGroupIndex = 0,
    this.selectedMuscleGroup,
    this.exercises = const [],
    this.isLoadingGroups = false,
    this.isLoadingExercises = false,
    this.error,
    this.exercisesError,
  });

  WorkoutsState copyWith({
    List<MusclesGroupDtoEntity>? muscleGroups,
    int? selectedMuscleGroupIndex,
    MuscleGroupDtoEntity? selectedMuscleGroup,
    List<MusclesDtoEntity>? exercises,
    bool? isLoadingGroups,
    bool? isLoadingExercises,
    String? error,
    String? exercisesError,
  }) {
    return WorkoutsState(
      muscleGroups: muscleGroups ?? this.muscleGroups,
      selectedMuscleGroupIndex:
          selectedMuscleGroupIndex ?? this.selectedMuscleGroupIndex,
      selectedMuscleGroup: selectedMuscleGroup ?? this.selectedMuscleGroup,
      exercises: exercises ?? this.exercises,
      isLoadingGroups: isLoadingGroups ?? this.isLoadingGroups,
      isLoadingExercises: isLoadingExercises ?? this.isLoadingExercises,
      error: error,
      exercisesError: exercisesError,
    );
  }

  @override
  List<Object?> get props => [
    muscleGroups,
    selectedMuscleGroupIndex,
    selectedMuscleGroup,
    exercises,
    isLoadingGroups,
    isLoadingExercises,
    error,
    exercisesError,
  ];
}
