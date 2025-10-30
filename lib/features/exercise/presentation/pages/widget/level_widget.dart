import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';

class LevelWidget extends StatelessWidget {
  final bool isSelected;
  final String level;
  const LevelWidget({super.key, required this.isSelected, required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: !isSelected
            ? Colors.transparent
            : context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(context.mdRadius(30)),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Text(
            level,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: AppFontWeight.extraBold,
            ),
          ),
        ),
      ),
    );
  }
}

