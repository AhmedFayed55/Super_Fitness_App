sealed class WorkoutsEvent {}

class LoadMuscleGroupsEvent extends WorkoutsEvent {}

class SelectMuscleGroupEvent extends WorkoutsEvent {
  final String muscleGroupId;
  final int index;

  SelectMuscleGroupEvent({required this.muscleGroupId, required this.index});
}
