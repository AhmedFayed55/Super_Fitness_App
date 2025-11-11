import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/constants.dart';

class CustomBlurContainer extends StatelessWidget {
  const CustomBlurContainer({
    super.key,
    required this.child,
    required this.height,
    this.radiusValue,
  });

  final Widget child;
  final double height;
  final double? radiusValue;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(context.mdRadius(20)),
        top: Radius.circular(radiusValue ?? 0),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppConstants.sigmaX,
          sigmaY: AppConstants.sigmaY,
        ),
        child: SizedBox(width: double.infinity, height: height, child: child),
      ),
    );
  }
}
