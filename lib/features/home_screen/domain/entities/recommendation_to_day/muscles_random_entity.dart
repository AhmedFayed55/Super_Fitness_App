import 'muscles_dto_entity.dart';

class MusclesRandomEntity {
  final String message;
  final int totalMuscles;
  final List<MusclesDtoEntity> musclesDtoEntity;

  MusclesRandomEntity({
    required this.message,
    required this.totalMuscles,
    required this.musclesDtoEntity,
  });
}
