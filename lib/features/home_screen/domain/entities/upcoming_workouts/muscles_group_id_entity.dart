import 'package:super_fitness_app/features/home_screen/domain/entities/recommendation_to_day/muscles_dto_entity.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscle_group_dto_entity.dart';

class MusclesGroupIdEntity {
  final String message;
  final MuscleGroupDtoEntity muscleGroupDtoEntity;
  final List<MusclesDtoEntity> musclesDtoEntity;

  MusclesGroupIdEntity({
    required this.message,
    required this.muscleGroupDtoEntity,
    required this.musclesDtoEntity,
  });
}
