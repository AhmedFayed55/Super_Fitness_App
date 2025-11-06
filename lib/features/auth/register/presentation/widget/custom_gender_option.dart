import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/utils/font_weight.dart';

class CustomGenderOption extends StatelessWidget {
  const CustomGenderOption({
    super.key,
    required this.onTap,
    required this.selected,
    required this.icon,
    required this.label,
  });
  final bool selected;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var color = context.colorScheme;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    final double size = (width < height ? width : height) * 0.22;
    return InkWell(
      borderRadius: BorderRadius.circular(size / 2),
      onTap: onTap,
      child: Container(
        height:size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? color.primary : color.onPrimary,
            width: 2,
          ),
          color: selected ? color.primary : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color.onPrimary, size: width * .10),
            verticalSpace(height * .01),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
