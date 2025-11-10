import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? context.pop,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: context.colorScheme.primary,
            ),
          ),

          Center(
            child: SvgPicture.asset(
              AppAssets.backButton,
              width: 15,
              height: 15,
            ),
          ),
        ],
      ),
    );
  }
}
