import 'muscles_group_dto_entity.dart';

class GetAllMusclesEntity {
  final String message;
  final List<MusclesGroupDtoEntity> musclesGroupDtoEntity;

  GetAllMusclesEntity({
    required this.message,
    required this.musclesGroupDtoEntity,
  });
}
