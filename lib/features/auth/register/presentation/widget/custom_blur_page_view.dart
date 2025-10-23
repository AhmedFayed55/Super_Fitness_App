import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:super_fitness_app/core/utils/constants.dart';

class CustomBlurPageView extends StatelessWidget {
  const CustomBlurPageView({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(screenWidth * .1),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: AppConstants.blurValueRegister,
          sigmaY: AppConstants.blurValueRegister,
        ),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
