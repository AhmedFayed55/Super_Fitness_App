import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var color = context.colorScheme;
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: height * .13,
        width: width * .25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * .8),
          border: Border.all(
            color: selected ? color.primary : color.onPrimary,
            width: 2,
          ),
          color: selected ? color.primary : Colors.transparent,
        ),
        child: Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(icon, fit: BoxFit.cover),
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
      ),
    );
  }
}
