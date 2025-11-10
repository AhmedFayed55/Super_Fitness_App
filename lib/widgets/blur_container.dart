import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/constants.dart';

class BlurContainer extends StatelessWidget {
  final List<Widget> children;
  final double? borderRadius;
  final double blurSigma;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const BlurContainer({
    super.key,
    required this.children,
    this.borderRadius,
    this.blurSigma = AppConstants.blurSigma,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? width * 0.05),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor ?? AppColors.glassBackground,
                borderRadius: BorderRadius.circular(
                  borderRadius ?? width * 0.05,
                ),
              ),
              padding:
                  padding ??
                  EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.02,
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
