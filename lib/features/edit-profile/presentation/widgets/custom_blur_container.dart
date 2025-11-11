import 'dart:ui';
import 'package:flutter/material.dart';

class CustomBlurContainerFields extends StatelessWidget {
  const CustomBlurContainerFields({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(screenWidth * .1),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
