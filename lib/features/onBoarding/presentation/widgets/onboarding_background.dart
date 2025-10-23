import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/utils/assets.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.onboardingMain),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: AppColors.black.withValues(alpha: 0.3)),
          ),
        ),
      ],
    );
  }
}
