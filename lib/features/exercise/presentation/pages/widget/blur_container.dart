import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class CustomBlurContainer extends StatelessWidget {
  const CustomBlurContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cmykColor.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(context.mdRadius(20)),
        ),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
