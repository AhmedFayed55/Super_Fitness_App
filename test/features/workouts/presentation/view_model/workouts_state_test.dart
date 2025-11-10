import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';
import 'package:super_fitness_app/features/workouts/presentation/view_model/workouts_state.dart';

void main() {
  group('WorkoutsState', () {
    test('Default constructor sets expected initial values', () {
      const state = WorkoutsState();

      expect(state.muscleGroups, isEmpty);
      expect(state.selectedMuscleGroupIndex, 0);
      expect(state.selectedMuscleGroup, isNull);
      expect(state.exercises, isEmpty);
      expect(state.isLoadingGroups, false);
      expect(state.isLoadingExercises, false);
      expect(state.error, isNull);
      expect(state.exercisesError, isNull);
    });

    test('copyWith updates only provided fields', () {
      const original = WorkoutsState();

      final newMuscleGroup = MusclesGroupDtoEntity(id: '1', name: 'Chest');
      final newSelectedGroup = MuscleGroupDtoEntity(id: '1', name: 'Chest');
      final newExercise = MusclesDtoEntity(
        id: 'ex1',
        name: 'Push Up',
        image: 'pushup.png',
      );

      final updated = original.copyWith(
        muscleGroups: [newMuscleGroup],
        selectedMuscleGroupIndex: 1,
        selectedMuscleGroup: newSelectedGroup,
        exercises: [newExercise],
        isLoadingGroups: true,
        error: 'Some error',
      );

      expect(updated.muscleGroups.first.name, 'Chest');
      expect(updated.selectedMuscleGroupIndex, 1);
      expect(updated.selectedMuscleGroup?.name, 'Chest');
      expect(updated.exercises.first.name, 'Push Up');
      expect(updated.isLoadingGroups, true);
      expect(updated.error, 'Some error');

      expect(updated.isLoadingExercises, original.isLoadingExercises);
      expect(updated.exercisesError, isNull);
    });

    test('Equatable correctly compares identical states', () {
      const s1 = WorkoutsState();
      const s2 = WorkoutsState();

      expect(s1, equals(s2));
    });

    test('Equatable detects differences correctly', () {
      const s1 = WorkoutsState();
      final s2 = s1.copyWith(isLoadingGroups: true);

      expect(s1 == s2, false);
    });

    test('copyWith retains existing values when parameters are null', () {
      final original = WorkoutsState(
        muscleGroups: [MusclesGroupDtoEntity(id: '1', name: 'Legs')],
        selectedMuscleGroupIndex: 2,
        isLoadingGroups: true,
      );

      final copied = original.copyWith();

      expect(copied.muscleGroups.first.name, 'Legs');
      expect(copied.selectedMuscleGroupIndex, 2);
      expect(copied.isLoadingGroups, true);
    });
  });
}
