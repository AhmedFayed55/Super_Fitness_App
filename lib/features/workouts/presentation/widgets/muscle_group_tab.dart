import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';

class MuscleGroupTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const MuscleGroupTab({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: context.mdW(8)),
        padding: EdgeInsets.symmetric(
          horizontal: context.mdW(20),
          vertical: context.mdH(10),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(context.mdRadius(25)),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: textTheme.labelSmall?.copyWith(
            fontWeight: AppFontWeight.extraBold,
          ),
        ),
      ),
    );
  }
}
