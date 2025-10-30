import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/home_screen/domain/entities/upcoming_workouts/muscles_group_dto_entity.dart';

class TabItem extends StatelessWidget {
  final MusclesGroupDtoEntity musclesGroupDtoEntity;
  final bool selected;

  const TabItem({
    super.key,
    required this.musclesGroupDtoEntity,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(20),
        color: selected ? Colors.red : Colors.transparent,
      ),
      child: Text(
        musclesGroupDtoEntity.name,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
