import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';

class CustomCirculerContainer extends StatelessWidget {
  const CustomCirculerContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.mdH(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        color: AppColors.cmykColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.mdW(8)),
        child: Center(child: child),
      ),
    );
  }
}
