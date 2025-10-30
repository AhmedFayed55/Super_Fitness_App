import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    var color = context.colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.mdH(20),
        horizontal: context.mdW(20),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: context.mdW(24),
          height: context.mdH(24),
          decoration: BoxDecoration(
            color: color.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(AppAssets.arrowBack, color: color.onPrimary),
          ),
        ),
      ),
    );
  }
}
